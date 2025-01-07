module 0xb644bb12e25eb4786db9a2ab2cc002b639fe4de6e1516159db0d726ad0287b08::SuiDoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    struct SuiDogeInfo has key {
        id: 0x2::object::UID,
        mint_cap: 0x2::coin::TreasuryCap<SUIDOGE>,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOGE>(arg0, 4, b"SuiDoge", b"Sui Doge Token", b"Sui Doge Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-doge.4everland.store/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGE>>(v1);
        let v3 = SuiDogeInfo{
            id       : 0x2::object::new(arg1),
            mint_cap : v2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOGE>>(0x2::coin::mint<SUIDOGE>(&mut v2, 100000000000000000, arg1), @0x33f64122713994fffe2c2aa71872f9142e39ce035616826f448d6df9f519deb8);
        0x2::transfer::share_object<SuiDogeInfo>(v3);
    }

    // decompiled from Move bytecode v6
}

