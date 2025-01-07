module 0x1d282f975a3b7c40d01215ec8176088a09f80c403b466a650d38e5561af9e92a::timazubr {
    struct TIMAZUBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMAZUBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMAZUBR>(arg0, 9, b"TIMAZUBR", b"Tsimafei", b"Timazubrhot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7363e4ea-4eda-4741-93c2-ac3881efc890.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMAZUBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TIMAZUBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

