module 0x54081959f965c2ca5091e0e235bf302b235f8c386efd9f5e0b2acae1b7b7f7da::fae {
    struct FAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAE>(arg0, 9, b"FAE", b"SAF", b"WT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d3e352d-dfe2-4b79-a2ce-3fef88777a9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

