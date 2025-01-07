module 0x5b34fd2e7337e9bd139db33700a2837d0d3e8ad403885ede21ed715b742752b9::galaxy {
    struct GALAXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GALAXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GALAXY>(arg0, 6, b"Galaxy", b"Galaxy Skin", b"The Galaxy Skin in Fortnite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8726_d30cd2beca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GALAXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GALAXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

