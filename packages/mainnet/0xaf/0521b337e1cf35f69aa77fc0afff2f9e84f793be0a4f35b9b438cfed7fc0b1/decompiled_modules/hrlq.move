module 0xaf0521b337e1cf35f69aa77fc0afff2f9e84f793be0a4f35b9b438cfed7fc0b1::hrlq {
    struct HRLQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRLQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRLQ>(arg0, 9, b"HRLQ", b"HARLY Q", b"your queen is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/446d5454-e47b-4597-953c-2edf2939778a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRLQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRLQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

