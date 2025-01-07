module 0x9d494cacac74c375b029dca7bb27ff607b90dbf919df4025f6b77578396e2c9c::kmn {
    struct KMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KMN>(arg0, 9, b"KMN", b"KILLER MAN", b"KILLER MAN MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c260115a-f7a8-4119-8161-62a40deb3d1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

