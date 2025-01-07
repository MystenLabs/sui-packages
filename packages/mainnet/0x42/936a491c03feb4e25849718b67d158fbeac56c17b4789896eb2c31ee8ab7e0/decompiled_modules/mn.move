module 0x42936a491c03feb4e25849718b67d158fbeac56c17b4789896eb2c31ee8ab7e0::mn {
    struct MN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MN>(arg0, 9, b"MN", b"Moon", b"A meme token under sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c492e1d8-e491-4708-b9a1-e3e72d7058fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MN>>(v1);
    }

    // decompiled from Move bytecode v6
}

