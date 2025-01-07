module 0x70fd784a8c37be0690089b604ab220deaf7d82e1d51ce010aa33777c8f8080c6::no_va1 {
    struct NO_VA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NO_VA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NO_VA1>(arg0, 9, b"NO_VA1", b"NOVA", b"NOVA IS NOVA : NOVA AI NOVA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ac14057-1e0a-4a79-bcb1-42ad1fafc332.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NO_VA1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NO_VA1>>(v1);
    }

    // decompiled from Move bytecode v6
}

