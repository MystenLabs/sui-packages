module 0xdcccd16c2fee08eb07b8fa4394e3685c88efad85a66cd942e23eed57bf634979::x10leverage {
    struct X10LEVERAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: X10LEVERAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X10LEVERAGE>(arg0, 6, b"X10leverage", b"TRUMPWIN", b"Ape in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_16_20_38_624b6656f9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X10LEVERAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X10LEVERAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

