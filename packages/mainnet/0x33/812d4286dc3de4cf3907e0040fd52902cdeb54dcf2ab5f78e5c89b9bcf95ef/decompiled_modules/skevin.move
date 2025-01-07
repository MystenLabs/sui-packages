module 0x33812d4286dc3de4cf3907e0040fd52902cdeb54dcf2ab5f78e5c89b9bcf95ef::skevin {
    struct SKEVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEVIN>(arg0, 6, b"SKEVIN", b"SANTA KEVIN SUI", b"Hey Im the new Santa in pixelmon and I will give gifts for Christmas and New Year this time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241129_165820_597_ff7a8c5fcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKEVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

