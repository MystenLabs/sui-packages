module 0xd0b93a612c957878d19bb9b9efecc196a2c15317458b28b09a0ed28bcea17889::eos {
    struct EOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EOS>(arg0, 6, b"EOS", b"EM ON SUI", b"First rapper figure on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_e140dacc9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

