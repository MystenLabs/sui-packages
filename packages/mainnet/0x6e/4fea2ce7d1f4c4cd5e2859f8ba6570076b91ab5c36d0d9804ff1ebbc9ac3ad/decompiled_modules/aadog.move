module 0x6e4fea2ce7d1f4c4cd5e2859f8ba6570076b91ab5c36d0d9804ff1ebbc9ac3ad::aadog {
    struct AADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AADOG>(arg0, 9, b"AADOG", b"Sangdogs", b"Adogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e9f57c3-f65a-4078-a536-d6ae6f2b4a91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

