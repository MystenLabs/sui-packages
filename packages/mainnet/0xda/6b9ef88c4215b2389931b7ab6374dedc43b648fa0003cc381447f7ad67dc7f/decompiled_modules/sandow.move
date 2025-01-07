module 0xda6b9ef88c4215b2389931b7ab6374dedc43b648fa0003cc381447f7ad67dc7f::sandow {
    struct SANDOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDOW>(arg0, 6, b"SANDOW", b"San Dow the Swimming Elephant", x"53616e20446f77206973207468652066616d6f7573207377696d6d696e6720656c657068616e742066726f6d207468652073616d65207a6f6f206173206d6f6f64656e670a0a636865636b2077656273697465200a0a49207468696e6b2069747320776f727468206d696c6c696f6e7320657370656369616c6c79206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6287_c0a4a46869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

