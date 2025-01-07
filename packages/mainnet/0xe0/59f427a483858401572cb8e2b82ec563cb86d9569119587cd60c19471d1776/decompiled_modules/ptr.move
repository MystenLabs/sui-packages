module 0xe059f427a483858401572cb8e2b82ec563cb86d9569119587cd60c19471d1776::ptr {
    struct PTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTR>(arg0, 9, b"PTR", b"Pantara", b"This is just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98247b33-aacb-45c0-b0ba-644489c3c520.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

