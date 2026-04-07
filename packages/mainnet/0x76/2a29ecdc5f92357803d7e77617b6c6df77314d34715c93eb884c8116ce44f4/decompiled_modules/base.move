module 0x762a29ecdc5f92357803d7e77617b6c6df77314d34715c93eb884c8116ce44f4::base {
    struct BASE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: 0x2::coin::Coin<BASE>) {
        0x2::coin::burn<BASE>(arg0, arg1);
    }

    fun init(arg0: BASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASE>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<BASE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BASE>>(v1);
    }

    public fun perform(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BASE> {
        0x2::coin::mint<BASE>(arg0, arg1, arg2)
    }

    public entry fun perform_to(arg0: &mut 0x2::coin::TreasuryCap<BASE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BASE>>(0x2::coin::mint<BASE>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

