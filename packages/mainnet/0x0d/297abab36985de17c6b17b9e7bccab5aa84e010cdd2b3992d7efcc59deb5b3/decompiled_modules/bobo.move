module 0xd297abab36985de17c6b17b9e7bccab5aa84e010cdd2b3992d7efcc59deb5b3::bobo {
    struct BOBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBO>(arg0, 9, b"BOBO", b"Bo", b"Bodktl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29a0aeb0-b5ea-4b98-98b1-9d33283ab224.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

