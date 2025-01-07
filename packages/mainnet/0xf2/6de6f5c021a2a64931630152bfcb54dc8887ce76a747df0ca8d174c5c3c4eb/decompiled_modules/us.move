module 0xf26de6f5c021a2a64931630152bfcb54dc8887ce76a747df0ca8d174c5c3c4eb::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<US>(arg0, 9, b"US", b"U-S", x"4d656d65436f696e20666f7265766572202e2e2e20e299beefb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/261954af-1421-4ae3-8df0-2a7b8976d0dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<US>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<US>>(v1);
    }

    // decompiled from Move bytecode v6
}

