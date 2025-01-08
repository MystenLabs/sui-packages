module 0x25e381bb3046a28a8cc2822cd5c3f514a6914a58e54f98414e88fb63ef5a844c::hsr {
    struct HSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSR>(arg0, 9, b"HSR", b"Hashirama", b"First homage of his village ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebfcc69a-2fe7-413d-a01d-c83ee3ad6958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

