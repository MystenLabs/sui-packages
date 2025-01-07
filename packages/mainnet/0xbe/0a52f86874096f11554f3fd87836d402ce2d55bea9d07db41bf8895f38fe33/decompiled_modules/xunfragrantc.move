module 0xbe0a52f86874096f11554f3fd87836d402ce2d55bea9d07db41bf8895f38fe33::xunfragrantc {
    struct XUNFRAGRANTC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUNFRAGRANTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XUNFRAGRANTC>>(0x2::coin::mint<XUNFRAGRANTC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XUNFRAGRANTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUNFRAGRANTC>(arg0, 6, b"XUNFRAGRANTC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUNFRAGRANTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUNFRAGRANTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

