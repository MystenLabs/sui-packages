module 0x73134253781dc81b042fe338e20a0547d7a3a4a7c07dff96a2d272a638a32484::telon {
    struct TELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TELON>(arg0, 9, b"TELON", b"TRUMPELON", b"Elon support Trump for president", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cb8432b-6ddb-4834-9e4f-c65bf92ddac3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

