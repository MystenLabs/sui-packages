module 0xe36db4d0dc6392bb691b0eac400ff3263019dcd3b4aea1f3f0e4676757e25307::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"TICKER IS BLUE #79BAEC", b"Blue is a primary color (A primary color is a main color on the color wheel. These colors are used to create secondary and tertiary colors.) but SUI built with a hex code of #79BAEC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_2_52a17b9e68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

