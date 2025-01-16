module 0xb8883ef75255a7d6e1f4d30fcac7b4f9dd792eeb5d54ab5298591b903030be2b::wummy {
    struct WUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUMMY>(arg0, 6, b"WUMMY", b"wummy", b"Gamblers gonna gamble", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000135851_5e5b593484.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

