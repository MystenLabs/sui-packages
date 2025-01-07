module 0x81c4aac1a82598a7108cc6068297452279b42876cb464a3a8f151a5a1f64108a::diddysui {
    struct DIDDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDYSUI>(arg0, 6, b"DiddySUI", b"MooDiddy", b"We're about to take over the memecoin scene, it's time for you guys to grab the big bags, or cry later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2b3d5171_9666_4e9e_8212_caa27f1823d9_5f9ca5cb92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

