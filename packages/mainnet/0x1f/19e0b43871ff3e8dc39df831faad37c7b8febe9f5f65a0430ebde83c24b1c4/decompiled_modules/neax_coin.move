module 0x1f19e0b43871ff3e8dc39df831faad37c7b8febe9f5f65a0430ebde83c24b1c4::neax_coin {
    struct NEAX_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAX_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAX_COIN>(arg0, 9, b"NEAX", b"Neax Coin", b"neax coin ai project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1776079302825-f88dcc9666003f99d3b8016b1a7f4b6c.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NEAX_COIN>>(0x2::coin::mint<NEAX_COIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAX_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEAX_COIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

