module 0x6651b1cad9f965a3688666ac102b2c8504cc8c35e58b94ffbde6cd93b716155c::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"Meme", x"4e68c6b02031207472c3b220c491c3b961", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb5ac48a-6a9c-4a83-975b-e04d6dfc696b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

