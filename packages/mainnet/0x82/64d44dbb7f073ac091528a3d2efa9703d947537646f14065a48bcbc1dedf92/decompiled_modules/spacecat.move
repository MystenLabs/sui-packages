module 0x8264d44dbb7f073ac091528a3d2efa9703d947537646f14065a48bcbc1dedf92::spacecat {
    struct SPACECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACECAT>(arg0, 6, b"SPACECAT", b"Space Cat", b"The invasion of Space Cat has begun on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profil_ezgif_com_video_to_webp_converter_0f6934b884.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

