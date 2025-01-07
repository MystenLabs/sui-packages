module 0xd3f433f35169a71c12341fd8aada97d1145e9c4a924f5ba4066bd0d6af4401b::scake {
    struct SCAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAKE>(arg0, 6, b"sCAKE", b"cake sui", b"just cake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_18_at_00_35_05_fa3871f1_1399a1b9d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

