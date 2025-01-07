module 0x3aa19333a0ccb08484255d5080a66439a8d6bf618539d6edeeb9fdaa913a30ec::nexa {
    struct NEXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXA>(arg0, 9, b"NEXA", b"Nexa", b"Nexa Token (NEXA) is a next-generation cryptocurrency designed to bring efficiency, security, and accessibility to the blockchain ecosystem. Nexa is built with a focus on speed and low transaction costs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/220f82ea-94d9-41ef-87dc-84b4b087fd7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

