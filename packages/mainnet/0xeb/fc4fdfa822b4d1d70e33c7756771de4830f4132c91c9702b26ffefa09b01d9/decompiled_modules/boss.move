module 0xebfc4fdfa822b4d1d70e33c7756771de4830f4132c91c9702b26ffefa09b01d9::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"boss", b"boss of bosses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kisspng_marlon_brando_the_godfather_vito_corleone_film_godfather_5b29e5b15a4496_0161546115294724333698_d2eee70f02.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

