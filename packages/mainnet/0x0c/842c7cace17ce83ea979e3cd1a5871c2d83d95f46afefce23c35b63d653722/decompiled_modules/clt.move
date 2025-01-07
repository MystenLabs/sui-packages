module 0xc842c7cace17ce83ea979e3cd1a5871c2d83d95f46afefce23c35b63d653722::clt {
    struct CLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLT>(arg0, 9, b"CLT", b"CHARLOTTE", b"A fine bitch ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac235287-8c8f-4ce6-b4f1-dff4dd586c62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

