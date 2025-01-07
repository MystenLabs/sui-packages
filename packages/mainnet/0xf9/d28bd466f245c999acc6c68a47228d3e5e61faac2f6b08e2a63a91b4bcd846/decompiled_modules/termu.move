module 0xf9d28bd466f245c999acc6c68a47228d3e5e61faac2f6b08e2a63a91b4bcd846::termu {
    struct TERMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMU>(arg0, 9, b"TERMU", b"Termu kong", b"Termukong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51789d84-2614-47dc-af27-e3e15033e52c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

