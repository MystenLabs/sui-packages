module 0x4998e75355f3bf39c8f2f6ad6847ded2e564858cd7e5c59602e7c624779eebae::sovv {
    struct SOVV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOVV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOVV>(arg0, 9, b"SOVV", b"Sov", b"Son on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba216dd9-affb-4bee-869c-dcb40ecd877c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOVV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOVV>>(v1);
    }

    // decompiled from Move bytecode v6
}

