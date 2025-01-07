module 0xbf9f60e2ba8f12f190ef02d3220d64e0db30afea4803873f50c9a25a322f0f72::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAX>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MAX> {
        assert!(0x2::coin::total_supply<MAX>(arg0) < 1000000000000000, 1);
        0x2::coin::mint<MAX>(arg0, arg1, arg2)
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAXTICKER", b"MAX", b"testing max supply", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

