module 0x45daee74d9468d8743889e25f757006605cf5b27db5f01b8e4f580cceb0e0cb0::haggis {
    struct HAGGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGGIS>(arg0, 6, b"HAGGIS", b"Haggis", b"New Born Haggis Pygmy Hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_11_04_19_04_14_a54204dca6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGGIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAGGIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

