module 0x43411dfdad7370aa5352ddbeb8b875a590b0f053a391d7e798f9ed2813ac70a8::picasso {
    struct PICASSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICASSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICASSO>(arg0, 9, b"PICASSO", x"f09f96bcefb88f205049434153534f", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fotos.perfil.com/2020/08/27/cropped/250/250/center/busto-de-mujer-picasso-1007764.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PICASSO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICASSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICASSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

