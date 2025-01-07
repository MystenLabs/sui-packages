module 0x8df1e6e55ec0b959f56ace9f61717231b03b1c1a0caf42e1428eba0c51b85b30::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 9, b"WOWO", b"WOWO MEMES", b"Memes of Wowo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f02aaf7-4531-4e33-bc82-5e4ab5122a13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

