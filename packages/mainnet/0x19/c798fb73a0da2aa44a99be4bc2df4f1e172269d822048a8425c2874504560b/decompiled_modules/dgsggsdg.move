module 0x19c798fb73a0da2aa44a99be4bc2df4f1e172269d822048a8425c2874504560b::dgsggsdg {
    struct DGSGGSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGGSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGGSDG>(arg0, 9, b"DGSGGSDG", b"SGfhfdh", b"GSGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bf7bb2a-cf5b-49bd-a719-e040f06e1dd0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGGSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGGSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

