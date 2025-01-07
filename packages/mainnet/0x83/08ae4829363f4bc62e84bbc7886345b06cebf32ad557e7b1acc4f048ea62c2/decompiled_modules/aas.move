module 0x8308ae4829363f4bc62e84bbc7886345b06cebf32ad557e7b1acc4f048ea62c2::aas {
    struct AAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAS>(arg0, 6, b"AAS", b"AAAS", b"AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moonlitebot_x_rachop_2fb9d102c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

