module 0x6ead73d8a71f7c8e5faade8cf80e70903486c302f60d1537eda2245c39547f0f::dak {
    struct DAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAK>(arg0, 6, b"dak", b"dak", b"Hi, I'm dak on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x41636c138167952207c88f5a75e433c9e880bc7bd5e4e46047d82be266d36712::dak::dak.png?size=lg&key=ff858f"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAK>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

