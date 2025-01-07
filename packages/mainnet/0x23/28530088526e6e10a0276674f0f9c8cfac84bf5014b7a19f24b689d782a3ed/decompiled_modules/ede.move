module 0x2328530088526e6e10a0276674f0f9c8cfac84bf5014b7a19f24b689d782a3ed::ede {
    struct EDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDE>(arg0, 9, b"EDE", b"Eddies", b"Eddie's token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5975b6b5-56d6-4144-9e89-f5dbb6352f73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

