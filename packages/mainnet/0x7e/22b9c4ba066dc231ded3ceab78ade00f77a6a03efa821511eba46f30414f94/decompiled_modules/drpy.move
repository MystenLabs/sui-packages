module 0x7e22b9c4ba066dc231ded3ceab78ade00f77a6a03efa821511eba46f30414f94::drpy {
    struct DRPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRPY>(arg0, 6, b"DRPY", b"Droppy", b"Droppy on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zrzut_ekranu_2024_09_18_135736_15e12a2329.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

