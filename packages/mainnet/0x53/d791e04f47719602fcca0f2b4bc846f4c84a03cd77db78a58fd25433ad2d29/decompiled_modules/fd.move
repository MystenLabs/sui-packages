module 0x53d791e04f47719602fcca0f2b4bc846f4c84a03cd77db78a58fd25433ad2d29::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 9, b"FD", b"J", b"HDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/891e02b7-e8b7-4779-994c-946bb0641d04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

