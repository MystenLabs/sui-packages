module 0x622d758e3f6396c6bef9f7e7930912599ba3ef69a6947af3dbade2b73ca517e3::wwss {
    struct WWSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWSS>(arg0, 6, b"WWSS", b"We will shine", b"We will shine on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_17_24_34_47b28fd0d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

