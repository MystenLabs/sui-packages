module 0x63b66d3d4ef38005ccc5f6e47f2cb9f563f3ae02409a5cfc37ab8e00ff1b0190::nz {
    struct NZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NZ>(arg0, 6, b"NZ", b"Suit As", b"Fan token dedicate to the Jesus of Rugby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Richie_Mc_Caw_ONZ_cropped_a02190ffa3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

