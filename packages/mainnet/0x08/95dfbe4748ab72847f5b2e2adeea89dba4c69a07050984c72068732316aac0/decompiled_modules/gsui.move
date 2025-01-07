module 0x895dfbe4748ab72847f5b2e2adeea89dba4c69a07050984c72068732316aac0::gsui {
    struct GSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSUI>(arg0, 6, b"GSUI", b"GAME SUISTOP", b"No Socials, the currency that sui needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050373_1b99f73aba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

