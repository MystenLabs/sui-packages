module 0x3572eb14c3ea7b16ef7103ffb2e30d142605da143983c700a89acf2bdabfdb91::w {
    struct W has drop {
        dummy_field: bool,
    }

    fun init(arg0: W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W>(arg0, 6, b"W", b"WREWARDS", b"A VIP experience through personalized rewards, leaderboards, raffles, free slot games and more!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735439495479.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

