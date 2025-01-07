module 0xdb9bedd2b449e67b7b53ad5ea02bb1158178e2222d452bd672be77f760e156d6::vale {
    struct VALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VALE>(arg0, 6, b"Vale", b"Vale coin", b"Vale Coin En honor a la encantadora Valentina, Vale Coin celebra la elegancia y la gracia de una mujer que sabe su valor. Despues de todo, cuando la vida te da limones, crea una criptomoneda! Con Vale Coin, puedes unirte a una comunidad que aprecia la belleza y la fortaleza. Porque en el mundo de Vale, cada transaccion es una declaracion de independencia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000255232_fff55a7250.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

