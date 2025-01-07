module 0x784afcb5876a225bca4f9122e5730e7bc70c2f2fd35b503b1371d4465e19da31::prk {
    struct PRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRK>(arg0, 6, b"PRK", b"PupRocket on sui", b"Recognizing the huge potential of Sui Network, one of the fastest and most secure blockchains today, PupRocket decided to build its community on this platform. With its fast transaction speed and high scalability, Sui Network will be the perfect launch pad for PupRocket to fulfill its mission.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_b267eda375.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

