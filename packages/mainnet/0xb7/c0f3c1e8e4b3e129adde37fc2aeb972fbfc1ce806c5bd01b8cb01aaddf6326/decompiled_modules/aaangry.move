module 0xb7c0f3c1e8e4b3e129adde37fc2aeb972fbfc1ce806c5bd01b8cb01aaddf6326::aaangry {
    struct AAANGRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAANGRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAANGRY>(arg0, 6, b"aaaNGRY", b"ANGRY", b"#$!@#$!@#$!@#$!@#$!@", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e5a928161a8c88d9cde8f8f9500877ba_da72ce9c36.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAANGRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAANGRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

