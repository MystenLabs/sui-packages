module 0xa324ebc9747b9abd15b33a404be48432f9ebedf052560257f6d8f468a053a99e::wewetoken {
    struct WEWETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWETOKEN>(arg0, 9, b"WEWETOKEN", b"Wewe", b"Wewe token in Sui BlockChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3dda288-7981-4795-a41b-b821dff4c625.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWETOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

