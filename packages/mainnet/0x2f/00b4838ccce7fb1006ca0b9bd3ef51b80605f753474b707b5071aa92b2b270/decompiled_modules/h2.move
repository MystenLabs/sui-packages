module 0x2f00b4838ccce7fb1006ca0b9bd3ef51b80605f753474b707b5071aa92b2b270::h2 {
    struct H2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H2>(arg0, 6, b"H2", b"HydroSui", b"H2 Hydrogen - The Element of the Universe, as well as the importance of SUI in the crypto world. Website: https://www.hydrosui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_37d095beeb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H2>>(v1);
    }

    // decompiled from Move bytecode v6
}

