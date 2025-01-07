module 0x1898a7ecbc0b3983a1bcb89ca8c8a45b3d5674a55fc0d6d13b0308e5a02b1f41::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"Bubbly The Cat", b"Join me for the epic adventure of \"BUBBLY THE CAT\". New animated episodes dropping each week. Follow the BUBBLY socials and prepare for the adventure of a lifetime with $BTC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964693161.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

