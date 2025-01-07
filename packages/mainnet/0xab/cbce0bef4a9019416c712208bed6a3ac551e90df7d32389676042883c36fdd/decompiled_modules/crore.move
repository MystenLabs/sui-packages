module 0xabcbce0bef4a9019416c712208bed6a3ac551e90df7d32389676042883c36fdd::crore {
    struct CRORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRORE>(arg0, 9, b"CRORE", b"Crorepati ", b"Kya Banega crorepati ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3658093e-409c-4b5a-a180-f5398ccbbcd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

