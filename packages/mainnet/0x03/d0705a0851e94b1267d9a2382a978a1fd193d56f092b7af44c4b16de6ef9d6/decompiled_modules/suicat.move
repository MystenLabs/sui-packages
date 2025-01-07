module 0x3d0705a0851e94b1267d9a2382a978a1fd193d56f092b7af44c4b16de6ef9d6::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"Suimons Cat", b"Suimon's cat, we are committed to transparency, integrity, and excellence in everything we do. We prioritize the needs and interests of our community members and strive to maintain open communication channels at all times. With a focus on continuous improvement and customer ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_png_2da1116f16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

