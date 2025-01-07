module 0x635c1f4ab9155e8c8739579d522ec42a8da79b1ed71f9d2c6d632f9330af5329::frogsui {
    struct FROGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGSUI>(arg0, 6, b"FrogSUI", b"Frog SUI", b"First Frog on Turbos Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953324880.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

