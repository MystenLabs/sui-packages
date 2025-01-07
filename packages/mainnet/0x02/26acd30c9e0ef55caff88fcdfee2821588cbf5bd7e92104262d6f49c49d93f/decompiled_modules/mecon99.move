module 0x226acd30c9e0ef55caff88fcdfee2821588cbf5bd7e92104262d6f49c49d93f::mecon99 {
    struct MECON99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECON99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECON99>(arg0, 9, b"MECON99", b"meoconlont", x"4dc3884f20434f4e204c4f4e20544f4e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a617ad5-198f-4663-b206-0fdbabc6ca7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECON99>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MECON99>>(v1);
    }

    // decompiled from Move bytecode v6
}

