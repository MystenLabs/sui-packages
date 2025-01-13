module 0x3160708a17c4ec46cafc9e7e28cf16ced8e9b7792c354cb9bd01884f7696f221::bingkycoin {
    struct BINGKYCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGKYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGKYCOIN>(arg0, 6, b"BINGKYCOIN", b"Bingky", x"4a757374206c6f6f6b2061742068696d2e2048657320646f696e672061207065726665637420696d7072657373696f6e206f66206120636869636b656e206e75676765742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250114_020126_776_98794ff566.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGKYCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINGKYCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

