module 0x7db753812fbe7a158528640594a08c050ce355bb12fbca5e6055c92aba012dcd::caren {
    struct CAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAREN>(arg0, 9, b"CAREN", b"KHCAR", x"496d6167696e6520612063617220746861742063617074757265732074686520737069726974206f662073706565642c20656e67696e656572696e6720657863656c6c656e63652c20616e64206175746f6d6f746976652070617373696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5be87ab3-64d6-4e92-bc10-2ff27597387a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

