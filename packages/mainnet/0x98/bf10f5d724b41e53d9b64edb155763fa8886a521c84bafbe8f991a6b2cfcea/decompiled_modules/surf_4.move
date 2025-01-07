module 0x98bf10f5d724b41e53d9b64edb155763fa8886a521c84bafbe8f991a6b2cfcea::surf_4 {
    struct SURF_4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURF_4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURF_4>(arg0, 9, b"SURF_4", b"Surf", b"Sui memes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1be0daf3-2653-4e2a-bfe4-453ac7456d01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURF_4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURF_4>>(v1);
    }

    // decompiled from Move bytecode v6
}

