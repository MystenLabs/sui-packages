module 0x47e00634dec1d1cf541863187cbd959b7a9205fbb60c2e56fb89a1d3ea7c1f27::dmc {
    struct DMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMC>(arg0, 8, b"DMC", b"DeLorean", x"546865204f6666696369616c2044654c6f7265616e204d6f746f7220436f6d70616e792057656233206163636f756e742e2044726976696e67207468652066757475726520776974682024444d43206275696c64696e67206f6e200a5375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/07ae0a0a-cc93-437e-a0e6-1171fc75a45b.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DMC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

