module 0xc23b9f04a5b74122e5506eb3200cb11848541ac64dac7a6865cbd96e567ef538::flwl {
    struct FLWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLWL>(arg0, 6, b"FLWL", b"FLUFFY OWL", b"Soft, wise, and always soaring high. Fluffy Owl is the meme for the wise investor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_051903308_1a27142f2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

