module 0xc6f39b5ce9772300d8d40a6bc08cd160fcdaa3a8b1ef1c9ba72cdb34e63ff027::staxi {
    struct STAXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STAXI>(arg0, 6, b"STAXI", b"SUITAXi", b"Take a free raid into the sui taxi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000060082_a7e683378a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAXI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAXI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

