module 0x6b8c70af8bbb1e30e3eee7a2c12cad9b854f1497c98705e69f674a8f41270635::bums {
    struct BUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMS>(arg0, 6, b"BUMS", b"Bums Adrp", b"After fire water  and a cardboard box  you can become a legend! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000620_b4e5131fb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

