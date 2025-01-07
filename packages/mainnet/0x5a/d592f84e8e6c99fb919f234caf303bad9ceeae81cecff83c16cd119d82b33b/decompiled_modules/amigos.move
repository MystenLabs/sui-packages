module 0x5ad592f84e8e6c99fb919f234caf303bad9ceeae81cecff83c16cd119d82b33b::amigos {
    struct AMIGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMIGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMIGOS>(arg0, 6, b"Amigos", b"Amigos coin ", b"Lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731088242486.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMIGOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMIGOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

