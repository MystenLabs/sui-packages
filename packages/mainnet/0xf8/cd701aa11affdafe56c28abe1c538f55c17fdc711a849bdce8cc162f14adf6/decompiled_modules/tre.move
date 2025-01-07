module 0xf8cd701aa11affdafe56c28abe1c538f55c17fdc711a849bdce8cc162f14adf6::tre {
    struct TRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRE>(arg0, 9, b"TRE", b"the tree", b"Build crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3079e9ba-36e9-4c27-9b27-2d39468b6a37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

