module 0xb8d3e96aaae42042bc85b5f46471079ddf459428cd37abe3b066a73c93788814::bdu {
    struct BDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDU>(arg0, 9, b"BDU", b"BABYDUCK", b"MEME COIN BUY THE DUCKS TO TAKE YOUR PICTURE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/096fa938-8c1b-45a7-9ea7-1305ce189c1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BDU>>(v1);
    }

    // decompiled from Move bytecode v6
}

