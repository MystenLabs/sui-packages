module 0xf353dc39f67671b50122fecb98c8a4fc5400d8969a1eacda9b95cab569903c20::grand {
    struct GRAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAND>(arg0, 6, b"GRAND", b"Grandmother Coin", b"Grandmother Coin ($GRAND) is the first memecoin that honors grandparents who, even without knowing blockchain, value the economy! Mixes humor, nostalgia and innovation. Trade classic grandma moments!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739492869054.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

