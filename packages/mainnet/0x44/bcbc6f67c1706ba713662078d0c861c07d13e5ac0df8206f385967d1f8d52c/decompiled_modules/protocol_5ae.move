module 0x44bcbc6f67c1706ba713662078d0c861c07d13e5ac0df8206f385967d1f8d52c::protocol_5ae {
    struct PROTOCOL_5AE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_5AE>, arg1: 0x2::coin::Coin<PROTOCOL_5AE>) {
        0x2::coin::burn<PROTOCOL_5AE>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_5AE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_5AE> {
        0x2::coin::mint<PROTOCOL_5AE>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_5AE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_5AE>>(0x2::coin::mint<PROTOCOL_5AE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL_5AE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_5AE>(arg0, 9, b"wSCA", b"Wrapped Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-jafPKiKKMb.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_5AE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_5AE>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

