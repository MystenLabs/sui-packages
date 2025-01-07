module 0x863bfc70a1ab594d728fa752bdbff26e0b5d79cdbd964710a1cce999d6cd0675::danky {
    struct DANKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANKY>(arg0, 6, b"DANKY", b"SUIDANK", b"Dank on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5507_20e65f2408.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

