module 0xac3cb76ec5f55c9d55fc4a171d737f54ca69d0915b13b15b81585a64ee23b0c0::moki {
    struct MOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKI>(arg0, 6, b"MOKI", b"SuiMOKI", b"Welcome to SuiMoki ($MOKI), where the thrill of the ride meets the excitement of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037324_33ccb2a2e8_76b232c82e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

