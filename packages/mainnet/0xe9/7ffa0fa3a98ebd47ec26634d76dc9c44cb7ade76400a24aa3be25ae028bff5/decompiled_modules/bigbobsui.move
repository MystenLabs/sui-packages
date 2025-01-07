module 0xe97ffa0fa3a98ebd47ec26634d76dc9c44cb7ade76400a24aa3be25ae028bff5::bigbobsui {
    struct BIGBOBSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIGBOBSUI>, arg1: 0x2::coin::Coin<BIGBOBSUI>) {
        0x2::coin::burn<BIGBOBSUI>(arg0, arg1);
    }

    fun init(arg0: BIGBOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBOBSUI>(arg0, 9, b"bigbobsui", b"bbs", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/JVo7Aaw.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGBOBSUI>>(v1);
        0x2::coin::mint_and_transfer<BIGBOBSUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBOBSUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIGBOBSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIGBOBSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

