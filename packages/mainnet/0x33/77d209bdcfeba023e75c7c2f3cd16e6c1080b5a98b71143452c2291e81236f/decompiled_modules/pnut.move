module 0x3377d209bdcfeba023e75c7c2f3cd16e6c1080b5a98b71143452c2291e81236f::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut the Squirrel", b"They tried to take me down, but Im still here  stronger, nuttier, and more legendary than ever! Im the squirrel they couldn't silence. Legends never die! $PNUT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F9029_EBC_E09_C_4421_AE_30_D8_F4_EC_608830_2140473c43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

