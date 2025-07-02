module 0xfc954a15fdaf009e815cb03dcdb8aa209a8d343e13cd5cce1bd6f5cd228c2287::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BS>(arg0, 9, b"BS", b"Banana_Sui", b"create token tool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.bananatool.com/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BS>(&mut v2, 888888000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v2, @0x51005de2c1b011205fe5719a79468feb94808cda0615c4772a466c965ef80c37);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BS>>(v1);
    }

    // decompiled from Move bytecode v6
}

