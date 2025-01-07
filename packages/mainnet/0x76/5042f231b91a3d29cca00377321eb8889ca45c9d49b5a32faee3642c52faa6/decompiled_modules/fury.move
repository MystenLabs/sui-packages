module 0x765042f231b91a3d29cca00377321eb8889ca45c9d49b5a32faee3642c52faa6::fury {
    struct FURY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURY>(arg0, 6, b"Fury", b"Suifury", b"Prepare for a fury like no other! Suifury is the meme coin thats ready to skyrocket to the top. Ready to ride the wave? The fury is just beginning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0396_3646f9a12e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURY>>(v1);
    }

    // decompiled from Move bytecode v6
}

