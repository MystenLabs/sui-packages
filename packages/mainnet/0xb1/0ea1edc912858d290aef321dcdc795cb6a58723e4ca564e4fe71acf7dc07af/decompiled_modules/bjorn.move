module 0xb10ea1edc912858d290aef321dcdc795cb6a58723e4ca564e4fe71acf7dc07af::bjorn {
    struct BJORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BJORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BJORN>(arg0, 6, b"BJORN", b"Bjorn", b"We'll make everyone $BJORN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/on_Pepe_Be_U_Be_AV_23_f61d8c242b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BJORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BJORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

