module 0xdda39121ec266352453f5aaaa3d26684c15c4e06a647d9022d6b52718f7830c::clpnd {
    struct CLPND has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLPND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLPND>(arg0, 9, b"CLPND", b"CoolPanda", b"CoolPanda is a fun memecoin featuring an adorable panda mascot. It aims to make cryptocurrency enjoyable and accessible, fostering a vibrant community through humor and engagement. Join CoolPanda for a lighthearted take on investing in the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b505af89-0e3c-4319-bd94-6cfabd21524e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLPND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLPND>>(v1);
    }

    // decompiled from Move bytecode v6
}

