module 0xa96c3b297711a81037e9f6ef24a6600fcb7fc5ff266db555108880509ab6f4e0::inter_1775206801603_yes {
    struct INTER_1775206801603_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTER_1775206801603_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTER_1775206801603_YES>(arg0, 0, b"INTER_1775206801603_YES", b"INTER_1775206801603 YES", b"INTER_1775206801603 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INTER_1775206801603_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTER_1775206801603_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

