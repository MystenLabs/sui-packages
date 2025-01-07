module 0xf57f6835e130c84d89dc10a1d6c10820a4419fa1c2235d59a05758b489e8d60c::hippos {
    struct HIPPOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOS>(arg0, 9, b"HIPPOS", b"HIPPOS", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSmdrndrqZ0NmDKE__Eo1l_4sFkeMv45ItQQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

