module 0x28d7dd427fb3e0b4d4ca76508ac9e1bd93356ae9d5a8844c27e88eb02f62987b::guid {
    struct GUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUID>(arg0, 9, b"GUID", b"uid", b"guid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/66aaa4c4-aba5-47ee-9a90-80e222f6f99b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

