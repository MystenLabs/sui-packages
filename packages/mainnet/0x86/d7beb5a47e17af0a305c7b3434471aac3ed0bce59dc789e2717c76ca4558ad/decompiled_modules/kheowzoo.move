module 0x86d7beb5a47e17af0a305c7b3434471aac3ed0bce59dc789e2717c76ca4558ad::kheowzoo {
    struct KHEOWZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHEOWZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHEOWZOO>(arg0, 6, b"Kheowzoo", b"khaokheowzoo", b"This is a place to protect wild animals. It is for learning and researching.The place where natural data is recorded is a place for lifelong learning and learning.Square. This is a good place for families to relax.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0174_d828cb6726.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHEOWZOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KHEOWZOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

