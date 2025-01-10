module 0x99ed399d9f3cc401b625402e0ad8bbcb187c5470806e9bfa9fcc7f974c74f45f::aaai {
    struct AAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAI>(arg0, 6, b"AAAI", b"AAA Cat AI", b"Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/si_L_Noz_J_400x400_8766623d25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

