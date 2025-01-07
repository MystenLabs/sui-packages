module 0x99be5996e5ddf752a9115163d21b8f945f896a67a30b571109c9bb1e111e42ab::hangyodon {
    struct HANGYODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANGYODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANGYODON>(arg0, 6, b"HANGYODON", b"Hang Yodon", b"Hangyodon is a nice guy who loves to make others laugh, but has a soft spot and doesn't like being alone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_235611_4bdb4c490d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANGYODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANGYODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

