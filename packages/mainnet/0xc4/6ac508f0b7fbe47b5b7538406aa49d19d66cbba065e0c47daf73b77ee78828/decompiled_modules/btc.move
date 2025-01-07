module 0xc46ac508f0b7fbe47b5b7538406aa49d19d66cbba065e0c47daf73b77ee78828::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"Bubbly The Cat", b"Join me in the epic adventures of \"BUBBLY THE CAT\". New funny animated episodes dropping each week. Follow the BUBBLY socials and prepare for the adventure of a lifetime with $BTC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bubbly_blink_2ad6867669.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

