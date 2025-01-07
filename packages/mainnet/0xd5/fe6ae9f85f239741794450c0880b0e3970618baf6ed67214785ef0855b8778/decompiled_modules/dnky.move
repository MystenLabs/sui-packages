module 0xd5fe6ae9f85f239741794450c0880b0e3970618baf6ed67214785ef0855b8778::dnky {
    struct DNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNKY>(arg0, 9, b"DNKY", b"Donkey", b"The Donkey Coin is a unique utility token that combines humor and utility in the crypto world. With its \"Stubborn Endurance\" superpower, it offers unwavering resilience against market volatility, ensuring holders steady growth and stability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6519b726-11b9-4e71-9f3c-c3f92591c322.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

