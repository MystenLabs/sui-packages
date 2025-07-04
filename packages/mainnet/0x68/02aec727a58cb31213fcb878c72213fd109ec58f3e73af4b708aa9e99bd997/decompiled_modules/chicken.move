module 0x6802aec727a58cb31213fcb878c72213fd109ec58f3e73af4b708aa9e99bd997::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 9, b"CHCKN", b"chicken", b"hero you need but not the one you deserve.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a29dcdeb-7fd0-42ff-88cf-a362793c9b8b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

