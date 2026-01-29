module 0xe8e71ea90378df3f75f7ac55b65d585e57337d4692e77332e8288b3848a927fe::base_3f6 {
    struct BASE_3F6 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE_3F6>, arg1: 0x2::coin::Coin<BASE_3F6>) {
        0x2::coin::burn<BASE_3F6>(arg0, arg1);
    }

    public fun forge(arg0: &mut 0x2::coin::TreasuryCap<BASE_3F6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE_3F6> {
        0x2::coin::mint<BASE_3F6>(arg0, arg1, arg2)
    }

    public entry fun forge_to(arg0: &mut 0x2::coin::TreasuryCap<BASE_3F6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE_3F6>>(0x2::coin::mint<BASE_3F6>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BASE_3F6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE_3F6>(arg0, 9, b"SEND_R4920", b"SEND (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-iV7JBq1o41.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE_3F6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE_3F6>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

