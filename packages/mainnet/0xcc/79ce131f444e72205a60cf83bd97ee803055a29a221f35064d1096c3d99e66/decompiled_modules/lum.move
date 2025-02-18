module 0xcc79ce131f444e72205a60cf83bd97ee803055a29a221f35064d1096c3d99e66::lum {
    struct LUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUM>(arg0, 9, b"LUM", b"Lumos", b"The best token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.quotev.com/a4tj6jbjaaaa.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUM>>(v2, @0xc2f45aa0ee89058023c1bbfd64a710d43ec5f6b16e52590bbad92d6a09a235e6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

