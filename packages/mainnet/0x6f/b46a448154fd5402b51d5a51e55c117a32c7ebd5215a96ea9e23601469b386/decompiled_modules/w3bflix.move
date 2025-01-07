module 0x6fb46a448154fd5402b51d5a51e55c117a32c7ebd5215a96ea9e23601469b386::w3bflix {
    struct W3BFLIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: W3BFLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<W3BFLIX>(arg0, 9, b"W3BFLIX", b"W3BFLIX 5", b"W3BFLIX meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b81e102e-92cd-4368-abf8-eeeec8ca15fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<W3BFLIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<W3BFLIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

