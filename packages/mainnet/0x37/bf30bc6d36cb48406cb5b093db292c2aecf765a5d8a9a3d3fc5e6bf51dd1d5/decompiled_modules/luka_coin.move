module 0x37bf30bc6d36cb48406cb5b093db292c2aecf765a5d8a9a3d3fc5e6bf51dd1d5::luka_coin {
    struct LUKA_COIN has drop {
        dummy_field: bool,
    }

    struct LukaTreasury has store, key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<LUKA_COIN>,
    }

    fun init(arg0: LUKA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKA_COIN>(arg0, 9, b"LUKA", b"LUKA", b"Luka memecoin (LUKA)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/2QW3k8g.png")), arg1);
        let v2 = LukaTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::public_transfer<LukaTreasury>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUKA_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to(arg0: address, arg1: u64, arg2: &mut LukaTreasury, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUKA_COIN>>(0x2::coin::mint<LUKA_COIN>(&mut arg2.cap, arg1, arg3), arg0);
    }

    public fun set_metadata_luka(arg0: &mut LukaTreasury, arg1: &mut 0x2::coin::CoinMetadata<LUKA_COIN>) {
        0x2::coin::update_name<LUKA_COIN>(&arg0.cap, arg1, 0x1::string::utf8(b"LUKA"));
        0x2::coin::update_symbol<LUKA_COIN>(&arg0.cap, arg1, 0x1::ascii::string(b"LUKA"));
        0x2::coin::update_description<LUKA_COIN>(&arg0.cap, arg1, 0x1::string::utf8(b"Luka memecoin (LUKA)"));
        0x2::coin::update_icon_url<LUKA_COIN>(&arg0.cap, arg1, 0x1::ascii::string(b"https://i.imgur.com/2QW3k8g.png"));
    }

    // decompiled from Move bytecode v6
}

