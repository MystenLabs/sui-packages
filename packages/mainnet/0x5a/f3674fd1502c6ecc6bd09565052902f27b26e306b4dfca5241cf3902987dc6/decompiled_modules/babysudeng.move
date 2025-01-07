module 0x5af3674fd1502c6ecc6bd09565052902f27b26e306b4dfca5241cf3902987dc6::babysudeng {
    struct BABYSUDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUDENG>(arg0, 9, b"BABYSUDENG", b"BABY SUDENG", b"Welcome baby sudeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x8993129d72e733985f7f1a00396cbd055bad6f817fee36576ce483c8bbb8b87b::sudeng::sudeng.png?size=xl&key=0c5782")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYSUDENG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUDENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSUDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

