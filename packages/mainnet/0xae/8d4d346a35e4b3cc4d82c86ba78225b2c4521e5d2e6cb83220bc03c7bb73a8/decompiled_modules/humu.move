module 0xae8d4d346a35e4b3cc4d82c86ba78225b2c4521e5d2e6cb83220bc03c7bb73a8::humu {
    struct HUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMU>(arg0, 6, b"HUMU", b"Humu the Fish", x"54686520726565662074726967676572666973682c20616c736f206b6e6f776e2062792069747320486177616969616e206e616d652068756d7568756d756e756b756e756b757075616120286d65616e696e67202774726967676572666973682077697468206120736e6f7574206c696b65206120706967292e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_09_40_50_b4e4d1fcec_f038808ea1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

