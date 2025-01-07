module 0xa615f60e6e9e52a120fbe73323f016a72796e6b56558d978a36408ce94b79743::afc {
    struct AFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFC>(arg0, 9, b"AFC", b"Angry face", b"Angry face old meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc1331f3-0de5-4c0f-9d81-0b5d8ee70243.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

