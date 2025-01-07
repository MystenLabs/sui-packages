module 0x20da9480dac75d6a532de7322fffbe6e46048e73fdd6e7d358c4cd86feb27b6::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 9, b"FLY", b"FLY CAM", b"FLY CAM GO TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9b07a21-07f1-497d-8223-94ebeabbc576-57EAF464-3313-41B0-8FFA-BF331ACE7BDF.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

