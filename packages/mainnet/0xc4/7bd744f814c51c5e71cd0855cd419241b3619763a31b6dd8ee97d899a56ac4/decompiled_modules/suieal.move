module 0xc47bd744f814c51c5e71cd0855cd419241b3619763a31b6dd8ee97d899a56ac4::suieal {
    struct SUIEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEAL>(arg0, 6, b"Suieal", b"suieal", b"the mascot of sui, the hat must stay on ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/transferir_1_d6437b39e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

