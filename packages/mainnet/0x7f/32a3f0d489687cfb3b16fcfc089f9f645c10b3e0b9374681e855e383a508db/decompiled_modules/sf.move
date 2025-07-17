module 0x7f32a3f0d489687cfb3b16fcfc089f9f645c10b3e0b9374681e855e383a508db::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 6, b"SF", b"SUIFFY", b"In the heart of the Sui network, hidden among humming validators, a lone coffee machine brewed the perfect shot of espresso.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicdzcwpe5jcvkt2zqxvtmj2enxydmbaw34ckw5ojy2p7mpet6t4te")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

