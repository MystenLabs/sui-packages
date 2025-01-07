module 0xed5a2b9d87f7784180aa4eb438372eb8d2f09ffc98021fa98eed5665aa52ea36::who {
    struct WHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHO>(arg0, 9, b"WHO", b"whoo", b"Who can you be?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d175d1f-18c8-4048-910e-fef6a59c4725.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

