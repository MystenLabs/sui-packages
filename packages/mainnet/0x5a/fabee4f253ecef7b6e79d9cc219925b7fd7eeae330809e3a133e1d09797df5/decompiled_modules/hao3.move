module 0x5afabee4f253ecef7b6e79d9cc219925b7fd7eeae330809e3a133e1d09797df5::hao3 {
    struct HAO3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAO3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAO3>(arg0, 6, b"HAO3", b"HAO003", b"003", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZbcBzqaB2d_nKF47Tvbs_d7rGi0T7ztQTAg&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAO3>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO3>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO3>>(v2);
    }

    // decompiled from Move bytecode v6
}

