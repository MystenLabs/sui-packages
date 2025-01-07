module 0xda34a6fa95030416221e0272935415ead0ee229d68a10db574c1cbd1015d85f0::sie {
    struct SIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIE>(arg0, 9, b"SIE", b"Former ", x"4920646f6ee2809974206b6e6f7720696620796f752063616e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54948031-fd7e-4275-8d2f-06780696f229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

