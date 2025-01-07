module 0xf1795fafd7077937fcd44e4c6a030c427b0397d6eaa02bc64ad484e59dd9af53::wewetoken {
    struct WEWETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWETOKEN>(arg0, 9, b"WEWETOKEN", b"Wewe", b"Wewe token in Sui BlockChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33e6f879-fa01-4de0-8e0f-295a0d30c0d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWETOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

