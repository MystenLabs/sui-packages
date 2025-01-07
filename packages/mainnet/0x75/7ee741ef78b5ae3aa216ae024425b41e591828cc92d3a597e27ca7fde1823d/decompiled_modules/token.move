module 0x757ee741ef78b5ae3aa216ae024425b41e591828cc92d3a597e27ca7fde1823d::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"HTCN", b"HeartChain INU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/etherpan/heartchain-presale-sui/refs/heads/main/public/logo.png?token=GHSAT0AAAAAACZBDACERLJRKBHKJR3MHFBEZZZUH4Q")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v2, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

