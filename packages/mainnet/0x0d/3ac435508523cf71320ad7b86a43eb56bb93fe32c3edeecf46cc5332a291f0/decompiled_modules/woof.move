module 0xd3ac435508523cf71320ad7b86a43eb56bb93fe32c3edeecf46cc5332a291f0::woof {
    struct WOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOF>(arg0, 6, b"Woof", b"WoofCoin", b"For snacks only !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Funny_Money_250x250_869e55a97f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

