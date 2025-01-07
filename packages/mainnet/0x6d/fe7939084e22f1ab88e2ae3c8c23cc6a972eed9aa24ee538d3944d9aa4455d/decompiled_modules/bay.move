module 0x6dfe7939084e22f1ab88e2ae3c8c23cc6a972eed9aa24ee538d3944d9aa4455d::bay {
    struct BAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAY>(arg0, 9, b"BAY", b"Tokenbay", b"Baytokenbay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c0af002-9618-476a-84d4-9df7b6fbf58a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

