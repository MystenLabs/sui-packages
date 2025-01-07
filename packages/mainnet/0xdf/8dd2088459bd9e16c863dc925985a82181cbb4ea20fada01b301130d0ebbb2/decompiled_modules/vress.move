module 0xdf8dd2088459bd9e16c863dc925985a82181cbb4ea20fada01b301130d0ebbb2::vress {
    struct VRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VRESS>(arg0, 6, b"VRESS", b"Vress", b"Vress is the smallest shark on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7728_de25cb195a.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

