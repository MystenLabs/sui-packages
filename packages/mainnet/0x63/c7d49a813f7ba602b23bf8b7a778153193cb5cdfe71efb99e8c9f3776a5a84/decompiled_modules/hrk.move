module 0x63c7d49a813f7ba602b23bf8b7a778153193cb5cdfe71efb99e8c9f3776a5a84::hrk {
    struct HRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRK>(arg0, 9, b"HRK", b"Harika", b"Btcharikasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbccf9ca-d3a3-4a32-a39f-49062ab21e0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

