module 0x20da60bbffe14a93419456aa292b199b1b8679e7025917731ddbf869ed20038a::seacat {
    struct SEACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEACAT>(arg0, 6, b"SEACAT", b"Sea Cat Sui", b"Sea Cat is a meme coin inspired by a quirky sea cat character, blending ocean vibes with meme culture. With a playful community and a focus on fun, Sea Cat aims to make waves in the crypto world through viral content and community-driven growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/width_800_cd0db478e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

