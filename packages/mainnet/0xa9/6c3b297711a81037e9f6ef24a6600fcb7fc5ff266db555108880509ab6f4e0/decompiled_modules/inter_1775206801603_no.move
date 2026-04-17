module 0xa96c3b297711a81037e9f6ef24a6600fcb7fc5ff266db555108880509ab6f4e0::inter_1775206801603_no {
    struct INTER_1775206801603_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTER_1775206801603_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INTER_1775206801603_NO>(arg0, 0, b"INTER_1775206801603_NO", b"INTER_1775206801603 NO", b"INTER_1775206801603 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INTER_1775206801603_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTER_1775206801603_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

