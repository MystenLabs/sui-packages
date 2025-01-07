module 0x433cc4e40c74ea5c6bb74ea8cecea0a669238a2c74eeb1f6828233deef4a9c1e::faq {
    struct FAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAQ>(arg0, 6, b"FAQ", b"FREQUENTLY ASKED QUESTIONS", x"57454c434f4d4520544f204652455155454e544c592041534b4544205155455354494f4e5320244641510a0a68747470733a2f2f666171746f6b656e2e78797a2f0a0a68747470733a2f2f747769747465722e636f6d2f4641515f5355490a0a68747470733a2f2f742e6d652f4641515f535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FAQ_d285a1d9f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

