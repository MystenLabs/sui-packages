module 0xb6b7cc1b7b4e7183ba42341c22f10c56b86d70e14a02d4f321769c687b2dabd2::yuan_da_tou {
    struct YUAN_DA_TOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUAN_DA_TOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUAN_DA_TOU>(arg0, 3, b"YDT", b"yuan da tou", b"silver coin,minted by the president of yuan shih-k'ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.ebaiyin.com/fileImgs/Ebaiyin.Ebaiyin/KingEditor/20171103/26db18bb30ac48a094f4d00481e7b66d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUAN_DA_TOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUAN_DA_TOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

