module 0x9e5012db1e5469d91af96c25a61c0f09aba4bf6634f1d7b6afab5d17a53ff16b::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/8090d72e-a659-4c91-b34d-1945aa734bcd/PotatoBruh.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/8090d72e-a659-4c91-b34d-1945aa734bcd/PotatoBruh.png"))
        };
        let v1 = b"aBRUH";
        let v2 = b"bPotato Bruh";
        let v3 = b"cBruh is ready to roll through the crypto game like a true degen OG.";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        0xc280be499d7831da76fa355666bb16f02f0ce8957f8a71418027cd35b5ea4edc::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 1500000000000, arg1);
    }

    // decompiled from Move bytecode v6
}

