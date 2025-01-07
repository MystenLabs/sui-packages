module 0x2815d625e08f4440667b5e9f9192f9f15d107a07843bbe50756bfd37b92833d9::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITE>, arg1: 0x2::coin::Coin<SUITE>) {
        0x2::coin::burn<SUITE>(arg0, arg1);
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 6, b"SUITE", b"SUITE", b"The premier suite of tools on $SUI. Twitter: https://twitter.com/SuiteOnSUI, Telegram: https://t.me/SuiteOnSUI, Website: https://suiteonsui.xyz/", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

