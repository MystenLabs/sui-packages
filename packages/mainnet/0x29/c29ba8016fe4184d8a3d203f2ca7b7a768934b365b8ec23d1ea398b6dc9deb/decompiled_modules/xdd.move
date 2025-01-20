module 0x29c29ba8016fe4184d8a3d203f2ca7b7a768934b365b8ec23d1ea398b6dc9deb::xdd {
    struct XDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDD>(arg0, 9, b"XDD", b"XrplDaddy", b"Daddy meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb7ecd87-ee94-4b6e-a098-cd2134afc47f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

