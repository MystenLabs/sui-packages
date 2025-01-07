module 0xbf3fe8091642b502a8dff84d68e35a131d36f9ae344cb49df1a0a4df4f419eaa::ton {
    struct TON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TON>(arg0, 9, b"TON", b"TONS", b"The open Network is a transparent payment Blockchain technology building on telegram. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b33b94a9-520e-4144-9b7d-11d101d10753.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TON>>(v1);
    }

    // decompiled from Move bytecode v6
}

