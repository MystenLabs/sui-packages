module 0x61c5109c25028907f050170152402d187d7a36d30cfcac8af2c831dae6daccd1::theles {
    struct THELES has drop {
        dummy_field: bool,
    }

    fun init(arg0: THELES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THELES>(arg0, 9, b"THELES", b"Theless", b"The beat theles", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b00e921f-9371-4166-984d-f33d0efe092e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THELES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THELES>>(v1);
    }

    // decompiled from Move bytecode v6
}

