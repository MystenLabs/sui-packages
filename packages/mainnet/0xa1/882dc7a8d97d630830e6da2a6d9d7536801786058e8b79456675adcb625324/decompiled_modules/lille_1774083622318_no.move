module 0xa1882dc7a8d97d630830e6da2a6d9d7536801786058e8b79456675adcb625324::lille_1774083622318_no {
    struct LILLE_1774083622318_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILLE_1774083622318_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILLE_1774083622318_NO>(arg0, 0, b"LILLE_1774083622318_NO", b"LILLE_1774083622318 NO", b"LILLE_1774083622318 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILLE_1774083622318_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILLE_1774083622318_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

