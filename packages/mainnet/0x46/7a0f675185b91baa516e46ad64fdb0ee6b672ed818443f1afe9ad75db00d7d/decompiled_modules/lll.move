module 0x467a0f675185b91baa516e46ad64fdb0ee6b672ed818443f1afe9ad75db00d7d::lll {
    struct LLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLL>(arg0, 9, b"LLL", b"Sleuleu", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5773ee46-7d3e-4e24-b55c-8442a0a51a4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

