module 0x56ce5aac02c03b931023a1a76bf5fbe7cd26236f7c7043451270ff2a8bce5a82::gikosui {
    struct GIKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIKOSUI>(arg0, 6, b"GikoSui", b"Giko Sui", b"GIKOSUI - Just Launch on MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGPRO_46cd6c25c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

