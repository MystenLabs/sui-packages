module 0x42b40f72ace64fc1be21dddd8dc20a162ce96d6de90f4136a1e9a23f2a244f2e::gadf {
    struct GADF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GADF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GADF>(arg0, 9, b"GADF", b"YOGA", b"RELAXATION WITH YOGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b2a21c4-a013-4bc4-b39d-75f60132730e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GADF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GADF>>(v1);
    }

    // decompiled from Move bytecode v6
}

