module 0x3265404acdfe0b601f7596ec837d734df980715612c6ce8ee977a1d0d94eee58::money {
    struct MONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONEY>(arg0, 6, b"MONEY", b"moneys calling", b"Pick up the phone, moneys calling. Time to bond. Join TG asap.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ci53_S_Ol6_400x400_97faf6848c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

