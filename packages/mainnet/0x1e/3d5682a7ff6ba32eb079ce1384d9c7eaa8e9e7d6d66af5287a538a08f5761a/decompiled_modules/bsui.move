module 0x1e3d5682a7ff6ba32eb079ce1384d9c7eaa8e9e7d6d66af5287a538a08f5761a::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"BabySui", b"Telegram: https://t.me/BabySUIAnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/Mv1hlkx.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, @0x7c31d8482bc50186da2e12b65784cc6c7dbdabf95d594afae9f276859e3ae88c);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BSUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

