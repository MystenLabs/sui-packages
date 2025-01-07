module 0x21ba0a68b7b61f646ee1d277d78dbf94ca40e59faa46252b89934d789c16ba1c::icp {
    struct ICP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICP>(arg0, 9, b"ICP", b"Iceple", b"Eat cream for the scream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03b6d796-eaef-4043-9bfc-e2457d1cabc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ICP>>(v1);
    }

    // decompiled from Move bytecode v6
}

