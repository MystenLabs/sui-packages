module 0x79c561c2683f6aed13ae7979bf1f8e94bfc21489ba4302895f3dedca426ef7d1::sudowiha {
    struct SUDOWIHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOWIHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOWIHA>(arg0, 6, b"SUDOWIHA", b"Sui Dog Wif Hat", x"576879206469642074686520686174206265636f6d6520626c75653f20426563617573652069742773206f6e2061206675636b696e20245355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidwh_2d1e3abee2_99d8bedb53.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOWIHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOWIHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

