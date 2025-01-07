module 0xd0af6e167a5960353ad0ea69c602be7d932870a085580022f98d54459860676a::phop {
    struct PHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOP>(arg0, 6, b"PHOP", b"PornHop", b"rex fucks blub while hopdog see", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2069_a088c91d56.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

