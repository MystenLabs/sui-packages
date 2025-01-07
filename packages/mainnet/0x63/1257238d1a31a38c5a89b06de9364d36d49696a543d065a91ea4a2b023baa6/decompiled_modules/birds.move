module 0x631257238d1a31a38c5a89b06de9364d36d49696a543d065a91ea4a2b023baa6::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 9, b"BIRDS", b"Bird", b"Flying bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e23f980a-30d3-4095-b281-3d2d060cc9d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

