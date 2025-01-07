module 0xff457bbe524a08cf2ca1320f9ede0f8285ebf96c5d43069444cf1c391a0aebbd::NSUP {
    struct NSUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUP>(arg0, 9, b"NSUP", b"NSUP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSUP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NSUP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<NSUP>>(0x2::coin::mint<NSUP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

