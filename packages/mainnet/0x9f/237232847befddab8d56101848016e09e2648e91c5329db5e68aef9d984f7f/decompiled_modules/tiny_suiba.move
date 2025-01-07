module 0x9f237232847befddab8d56101848016e09e2648e91c5329db5e68aef9d984f7f::tiny_suiba {
    struct TINY_SUIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TINY_SUIBA>, arg1: 0x2::coin::Coin<TINY_SUIBA>) {
        0x2::coin::burn<TINY_SUIBA>(arg0, arg1);
    }

    fun init(arg0: TINY_SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINY_SUIBA>(arg0, 9, b"tSUIBA", b"Tiny Suiba", b"https://suibacoin.com/suiba.svg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TINY_SUIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINY_SUIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TINY_SUIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TINY_SUIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

