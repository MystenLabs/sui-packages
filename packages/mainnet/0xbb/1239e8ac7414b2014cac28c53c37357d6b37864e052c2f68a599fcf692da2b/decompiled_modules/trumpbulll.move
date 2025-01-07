module 0xbb1239e8ac7414b2014cac28c53c37357d6b37864e052c2f68a599fcf692da2b::trumpbulll {
    struct TRUMPBULLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPBULLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPBULLL>(arg0, 9, b"TRUMPBULLL", b"Bulll trum", b"Jjjjjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4897a02-cb88-49ab-9479-c02a6020d832.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBULLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBULLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

