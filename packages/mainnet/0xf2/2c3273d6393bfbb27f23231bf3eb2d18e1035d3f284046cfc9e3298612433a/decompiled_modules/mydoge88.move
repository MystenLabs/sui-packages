module 0xf22c3273d6393bfbb27f23231bf3eb2d18e1035d3f284046cfc9e3298612433a::mydoge88 {
    struct MYDOGE88 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYDOGE88, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYDOGE88>(arg0, 9, b"MYDOGE88", b"mydoge", b"cho me me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1297bd16-0568-4784-a2b1-d579ff5114de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYDOGE88>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYDOGE88>>(v1);
    }

    // decompiled from Move bytecode v6
}

