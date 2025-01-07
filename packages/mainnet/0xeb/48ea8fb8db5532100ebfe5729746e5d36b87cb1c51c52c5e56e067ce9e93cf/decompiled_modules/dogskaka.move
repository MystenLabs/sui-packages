module 0xeb48ea8fb8db5532100ebfe5729746e5d36b87cb1c51c52c5e56e067ce9e93cf::dogskaka {
    struct DOGSKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAKA>(arg0, 9, b"DOGSKAKA", b"Wawe", b"You why to me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bf89b2f-34f1-4dae-a6c8-faf51e530104.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

