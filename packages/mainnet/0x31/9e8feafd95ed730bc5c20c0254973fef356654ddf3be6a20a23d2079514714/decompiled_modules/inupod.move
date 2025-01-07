module 0x319e8feafd95ed730bc5c20c0254973fef356654ddf3be6a20a23d2079514714::inupod {
    struct INUPOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUPOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUPOD>(arg0, 6, b"INUPOD", b"Inu Poodle", b"Best meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000328813_0d8e8c298b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUPOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUPOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

