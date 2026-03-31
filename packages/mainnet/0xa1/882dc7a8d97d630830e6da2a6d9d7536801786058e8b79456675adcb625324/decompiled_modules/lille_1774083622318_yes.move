module 0xa1882dc7a8d97d630830e6da2a6d9d7536801786058e8b79456675adcb625324::lille_1774083622318_yes {
    struct LILLE_1774083622318_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILLE_1774083622318_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILLE_1774083622318_YES>(arg0, 0, b"LILLE_1774083622318_YES", b"LILLE_1774083622318 YES", b"LILLE_1774083622318 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILLE_1774083622318_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILLE_1774083622318_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

