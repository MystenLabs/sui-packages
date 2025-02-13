module 0xe0ec759217cdebce113a01abc79809e905aac771eef0c20d1688190d70ee4b7e::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 9, b"PIG", b"Smilepig", b"Just Happy pig)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa6e5732-1edc-4827-bdfe-8cec50005312.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

