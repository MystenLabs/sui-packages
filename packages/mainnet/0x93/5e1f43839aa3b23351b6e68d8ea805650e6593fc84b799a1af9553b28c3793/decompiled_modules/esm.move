module 0x935e1f43839aa3b23351b6e68d8ea805650e6593fc84b799a1af9553b28c3793::esm {
    struct ESM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESM>(arg0, 9, b"ESM", b"ELYSIUM", b"Token Juggernaut Wars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b42c83b-c8ef-474e-aea0-c93911f04d34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESM>>(v1);
    }

    // decompiled from Move bytecode v6
}

