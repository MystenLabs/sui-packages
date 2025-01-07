module 0xce35cbf73b0acfcd61154b3938f1627ae0af88595601b3db154ca8e5e9512f97::hedg {
    struct HEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDG>(arg0, 9, b"HEDG", b"Hedgehog", b"a cute hedgehog,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a1c7192-76e9-4fe1-a0c5-ac8d38bf6681.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

