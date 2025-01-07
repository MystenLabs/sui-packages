module 0x1e59dca07b50e27d116fa808910624790eb6b88349ae049ab84c712e330b294a::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 9, b"SUD", b"Superfuud", b"Fud or lose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83453e16-2e46-4a79-9b0a-e88de6a8da5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

