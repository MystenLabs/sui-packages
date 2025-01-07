module 0xf9fa5dec8678d8b50982576fd8446e045522abc3ac0af0bad8c914fa9ca997fe::wingie {
    struct WINGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINGIE>(arg0, 2, b"Wingie", b"Wingie The Dog", b"Wingie The Dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w7.pngwing.com/pngs/574/379/png-transparent-dog-cat-puppy-pet-poster-cartoon-puppy-cartoon-character-mammal-painted.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WINGIE>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINGIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

