module 0x4ce64972ec142adc3d2b9ea66623f356000789f9ef84b581c06ddbec2aac006::wallbear {
    struct WALLBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLBEAR>(arg0, 6, b"WallBear", b"Walrus with baby bear", b"WallBear is an old walrus with a baby bear. They are here to eat all the fishes on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/00260235_45b3_4c82_b2d2_d64392179ad2_d64e3791b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

