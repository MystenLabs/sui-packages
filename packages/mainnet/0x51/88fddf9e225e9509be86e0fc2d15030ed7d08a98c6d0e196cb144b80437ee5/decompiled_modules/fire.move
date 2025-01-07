module 0x5188fddf9e225e9509be86e0fc2d15030ed7d08a98c6d0e196cb144b80437ee5::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRE>(arg0, 9, b"FIRE", b"BoomSUI", b"LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2023f240-2ee0-4d4f-a119-e72f6dba56c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

