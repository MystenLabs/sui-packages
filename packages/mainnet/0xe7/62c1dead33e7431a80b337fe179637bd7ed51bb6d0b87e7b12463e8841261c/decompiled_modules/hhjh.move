module 0xe762c1dead33e7431a80b337fe179637bd7ed51bb6d0b87e7b12463e8841261c::hhjh {
    struct HHJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHJH>(arg0, 9, b"HHJH", b"Hhj", b"Cugihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ac404f3-f3c5-46b7-ac78-c682b9731866.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHJH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHJH>>(v1);
    }

    // decompiled from Move bytecode v6
}

