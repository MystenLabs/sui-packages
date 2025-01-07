module 0x83fb24ca28a93391432bffda14b03e040823960cf8499a6d11a84d070c7fe75b::njw {
    struct NJW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJW>(arg0, 9, b"NJW", b"Najwas", b"Family token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b3da9ff-9112-495d-8553-d154c6e75b8c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJW>>(v1);
    }

    // decompiled from Move bytecode v6
}

