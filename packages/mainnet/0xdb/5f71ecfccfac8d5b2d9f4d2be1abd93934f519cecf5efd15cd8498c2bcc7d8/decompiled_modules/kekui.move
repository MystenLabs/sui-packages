module 0xdb5f71ecfccfac8d5b2d9f4d2be1abd93934f519cecf5efd15cd8498c2bcc7d8::kekui {
    struct KEKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKUI>(arg0, 6, b"KEKUI", b"KEKUI SUI", x"416e6369656e74204368616f7320476f64205475726e6564204469676974616c204c6567656e64205469636b65723a244b454b55490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st1_ec59141dfd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEKUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

