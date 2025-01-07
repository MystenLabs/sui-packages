module 0x2bcac5b38c2936d2a36ab8f4b0dd4ccfd14956721ce505fc92f648f44027a52::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"Fin", b"Finlay", b"Finlay the shark dog, I mean look how cute he is!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/finlay_1c8ded1f0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

