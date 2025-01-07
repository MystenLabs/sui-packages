module 0x2e6dfebd794706c4406406adc6df5be0b25da70f93a3192871d8b59f64a97db1::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 9, b"SCM", b"SCAM", b"SCAM. SCAM. SCAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCM>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

