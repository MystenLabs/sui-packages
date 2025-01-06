module 0x7343f717fcc21ed12ab629d36b1c4fa1a64124c9daf243132938a916c80308ac::bcs {
    struct BCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCS>(arg0, 6, b"BCS", b"Buttercup on sui", b"Welcome to the world of mischievous golden retrievers! Get ready to take the market by storm with Buttercup!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_05_23_11_00_c9719848c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

