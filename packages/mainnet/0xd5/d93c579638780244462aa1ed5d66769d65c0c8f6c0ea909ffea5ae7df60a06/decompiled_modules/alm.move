module 0xd5d93c579638780244462aa1ed5d66769d65c0c8f6c0ea909ffea5ae7df60a06::alm {
    struct ALM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALM>(arg0, 9, b"ALM", b"Almanac ", b"Gaming token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59dae78f-272c-4ae2-ae5b-ee1d4eee593d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALM>>(v1);
    }

    // decompiled from Move bytecode v6
}

