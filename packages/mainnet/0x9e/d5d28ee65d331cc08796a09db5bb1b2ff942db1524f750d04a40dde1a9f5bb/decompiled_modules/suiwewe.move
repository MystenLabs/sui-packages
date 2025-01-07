module 0x9ed5d28ee65d331cc08796a09db5bb1b2ff942db1524f750d04a40dde1a9f5bb::suiwewe {
    struct SUIWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEWE>(arg0, 9, b"SUIWEWE", b"WEWW", b"Og of WEWE on sui is here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b096f696-1af8-4668-8a6a-9f370a52da43.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

