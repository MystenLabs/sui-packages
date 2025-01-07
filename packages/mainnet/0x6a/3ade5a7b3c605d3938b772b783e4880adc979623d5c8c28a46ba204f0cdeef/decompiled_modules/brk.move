module 0x6a3ade5a7b3c605d3938b772b783e4880adc979623d5c8c28a46ba204f0cdeef::brk {
    struct BRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRK>(arg0, 9, b"BRK", b"Badrosk", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRK>(&mut v2, 33000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

