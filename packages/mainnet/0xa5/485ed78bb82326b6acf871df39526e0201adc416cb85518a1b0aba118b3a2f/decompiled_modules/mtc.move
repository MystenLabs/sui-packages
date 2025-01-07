module 0xa5485ed78bb82326b6acf871df39526e0201adc416cb85518a1b0aba118b3a2f::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTC>(arg0, 6, b"MTC", b"Mike Tyson Coin", b"$MTC is a decentralized meme coin build on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731783573866.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

