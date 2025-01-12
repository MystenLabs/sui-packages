module 0x55ea63a310b400ad54a16adcc599e8282157d5ed5f82d73574606b7d0d0288ca::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Usdt token", b"ether (USDT) is a widely used stablecoin pegged to the value of the US dollar at a 1:1 ratio. It is designed to provide price stability, enabling seamless transactions across cryptocurrencies and fiat currencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/5da099b5-232b-4bbe-832e-64a13a102626.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

