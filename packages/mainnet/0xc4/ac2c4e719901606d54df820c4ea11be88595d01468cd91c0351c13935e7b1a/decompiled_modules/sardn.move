module 0xc4ac2c4e719901606d54df820c4ea11be88595d01468cd91c0351c13935e7b1a::sardn {
    struct SARDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARDN>(arg0, 6, b"SARDN", b"Sardana", b"https://www.sardana.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a7w3_Lz_Dn_400x400_7da59a7ab3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SARDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

