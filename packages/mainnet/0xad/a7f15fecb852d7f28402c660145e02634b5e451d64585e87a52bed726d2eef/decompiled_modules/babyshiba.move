module 0xada7f15fecb852d7f28402c660145e02634b5e451d64585e87a52bed726d2eef::babyshiba {
    struct BABYSHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHIBA>(arg0, 6, b"BABYSHIBA", b"BABY SHIBA", b"Baby Sheba's currency is a currency for fun, but at Al-Mutaqlil we are looking forward to long-term goals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Shiba_Inu_coin_logo_a231bcf6e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

