module 0xb70c99a4bdeae623826104d8a2615a46c6a9d244b0fd5e48012781f1e5b21d51::zec {
    struct ZEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEC>(arg0, 9, b"ZEC", b"Zecmet", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91c067c8-18ab-4357-9e0e-d814bb2bab98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

