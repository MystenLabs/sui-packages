module 0xf656a44085eed4877627142876b925c8ec95ba19745fa0f673ba068b6136d5e::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUI>(arg0, 6, b"KUI", b"SharKui", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d653b206974732061205245564f4c5554494f4e210a5448495320544f4b454e2057494c4c20444f2031303030580a4c45474954494d4154452050524f4a454354", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_12_13_15_52_05_726_035513_1_e24289db1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

