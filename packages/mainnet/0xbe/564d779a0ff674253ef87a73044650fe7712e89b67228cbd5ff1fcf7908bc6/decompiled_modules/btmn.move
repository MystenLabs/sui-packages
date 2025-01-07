module 0xbe564d779a0ff674253ef87a73044650fe7712e89b67228cbd5ff1fcf7908bc6::btmn {
    struct BTMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTMN>(arg0, 9, b"BTMN", b"BatmanCoin", b"The Lord Of Darkness Has Been Arrived", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0fc1a311-ff2b-402a-982d-a7e643953e8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

