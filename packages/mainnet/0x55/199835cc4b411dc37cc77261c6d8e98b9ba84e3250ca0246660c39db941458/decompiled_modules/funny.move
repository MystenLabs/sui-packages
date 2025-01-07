module 0x55199835cc4b411dc37cc77261c6d8e98b9ba84e3250ca0246660c39db941458::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 6, b"FUNNY", b"Funny The Bunny", b"SHOWTIME!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952435703.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

