module 0x66234731ccd4eee1b0617615b45a35a9036e37bdde3d3ca1037c0f6ed078c7f2::dbaby {
    struct DBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBABY>(arg0, 6, b"DBaby", b"Dancing Baby", b"The OG internet meme of them all now coming to SUI. Join the journey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dbaby_834aedc850.GIF")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

