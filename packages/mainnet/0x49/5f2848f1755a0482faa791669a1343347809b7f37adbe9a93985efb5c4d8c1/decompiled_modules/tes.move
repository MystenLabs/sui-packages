module 0x495f2848f1755a0482faa791669a1343347809b7f37adbe9a93985efb5c4d8c1::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TES>(arg0, 6, b"TES", x"746573756920f09f9088e2808de2ac9b", x"544553207468652063757465737420636174206f6e2053554920f09f9088e2808de2ac9b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734257101503.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

