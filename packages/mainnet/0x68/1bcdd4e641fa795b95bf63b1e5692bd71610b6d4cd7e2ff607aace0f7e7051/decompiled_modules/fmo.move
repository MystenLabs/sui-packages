module 0x681bcdd4e641fa795b95bf63b1e5692bd71610b6d4cd7e2ff607aace0f7e7051::fmo {
    struct FMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMO>(arg0, 9, b"FMO", b"Fomo", b"FOMO or lose out. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d649d34a-66c9-405c-9007-d4a2f6ae4cb9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

