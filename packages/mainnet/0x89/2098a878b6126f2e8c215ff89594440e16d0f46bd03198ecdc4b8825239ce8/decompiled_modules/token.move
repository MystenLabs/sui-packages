module 0x892098a878b6126f2e8c215ff89594440e16d0f46bd03198ecdc4b8825239ce8::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"HTCN", b"HeartChain INU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/etherpan/heartchain-presale-sui/refs/heads/main/public/logo.png?token=GHSAT0AAAAAACZBDACERLJRKBHKJR3MHFBEZZZUH4Q")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v2, 500000000000000000, arg1), 0x2::address::from_u256(58555732576838652307322675474306795026597880425169286761684111137485055243726));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

