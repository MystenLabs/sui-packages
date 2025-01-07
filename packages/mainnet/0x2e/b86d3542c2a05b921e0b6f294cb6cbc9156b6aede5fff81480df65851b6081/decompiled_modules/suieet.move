module 0x2eb86d3542c2a05b921e0b6f294cb6cbc9156b6aede5fff81480df65851b6081::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"SUIEET", b"Suieet Candy", x"546865205377656574657374204d656d65206f6e205355490a0a68747470733a2f2f742e6d652f537569656574636f6d6d756e6974790a68747470733a2f2f782e636f6d2f5375696565745f3f743d39615547643833796e65696d4862466357316771684126733d30390a68747470733a2f2f7375696565742e78797a2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suieet_logo_ae90e850c6_7554112e27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

