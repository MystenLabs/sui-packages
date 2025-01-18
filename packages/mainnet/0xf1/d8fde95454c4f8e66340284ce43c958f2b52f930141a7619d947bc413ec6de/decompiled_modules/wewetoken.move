module 0xf1d8fde95454c4f8e66340284ce43c958f2b52f930141a7619d947bc413ec6de::wewetoken {
    struct WEWETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWETOKEN>(arg0, 9, b"WEWETOKEN", b"Wewe", b"Wewe token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db722289-3a13-4107-8b40-640c98a1a5a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWETOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

