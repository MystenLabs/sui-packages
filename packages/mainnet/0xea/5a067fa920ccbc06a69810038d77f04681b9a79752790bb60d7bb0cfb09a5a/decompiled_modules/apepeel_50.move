module 0xea5a067fa920ccbc06a69810038d77f04681b9a79752790bb60d7bb0cfb09a5a::apepeel_50 {
    struct APEPEEL_50 has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEPEEL_50, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEPEEL_50>(arg0, 9, b"APEPEEL_50", b"ApePeel", b"Peel Back Profits, One Banana at a Time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3bff907-8333-4898-be21-be89c188fbe0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEPEEL_50>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APEPEEL_50>>(v1);
    }

    // decompiled from Move bytecode v6
}

