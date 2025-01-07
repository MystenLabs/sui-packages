module 0x1cb1c65bfe1e5dfb120de9b35e28752aded6ba48c31bfabfb604dd60558f48e::bigb {
    struct BIGB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIGB>, arg1: 0x2::coin::Coin<BIGB>) {
        0x2::coin::burn<BIGB>(arg0, arg1);
    }

    fun init(arg0: BIGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BIGB>(arg0, 6, b"BIGB", b"Big Brother", b"This is the Big Brother!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.wikia.nocookie.net/bigbrother/images/9/92/Mexico_4.jpg/revision/latest"))), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BIGB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIGB>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIGB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIGB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

