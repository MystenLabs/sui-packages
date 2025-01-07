module 0xfccc52a54f141154ca170a4903477f269561ea4dd4545e9b5e0bf6bf4a471f17::popeye {
    struct POPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYE>(arg0, 6, b"POPEYE", b"Popeye the Sailor", b"Ahoy, Matey! $Popeye enters the public domain and now joins the Sui chain too!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logojpg_6493c6d9f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

