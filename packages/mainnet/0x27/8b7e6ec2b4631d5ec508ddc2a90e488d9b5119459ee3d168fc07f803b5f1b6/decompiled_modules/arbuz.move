module 0x278b7e6ec2b4631d5ec508ddc2a90e488d9b5119459ee3d168fc07f803b5f1b6::arbuz {
    struct ARBUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARBUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARBUZ>(arg0, 9, b"ARBUZ", b"Arbuz", b"The token is created for entertainment purposes only!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86d89a82-b32d-4a81-a1ef-49be1e56acd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARBUZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARBUZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

