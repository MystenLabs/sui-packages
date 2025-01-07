module 0x86bcc79fe32e7a8914e03f878b0525cf245593a741f8d80e990a8034cfdc5fd0::cook {
    struct COOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOK>(arg0, 6, b"Cook", b"Cookonsui", b"Bon appetit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731524206631.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

