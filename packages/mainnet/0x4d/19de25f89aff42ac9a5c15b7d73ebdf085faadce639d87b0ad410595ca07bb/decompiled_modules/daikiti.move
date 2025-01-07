module 0x4d19de25f89aff42ac9a5c15b7d73ebdf085faadce639d87b0ad410595ca07bb::daikiti {
    struct DAIKITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAIKITI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAIKITI>(arg0, 6, b"DAIKITI", b"Daikiti", b"Just cute ai kittens ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241215_093232_324_2e21e9e3c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAIKITI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAIKITI>>(v1);
    }

    // decompiled from Move bytecode v6
}

