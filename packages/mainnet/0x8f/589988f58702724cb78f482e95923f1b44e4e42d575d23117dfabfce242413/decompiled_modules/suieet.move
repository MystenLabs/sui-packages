module 0x8f589988f58702724cb78f482e95923f1b44e4e42d575d23117dfabfce242413::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"SUIEET", b"Suieet", b"Official launch of Suieet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suieet_fd6b08dfc5_e6ebf544e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

