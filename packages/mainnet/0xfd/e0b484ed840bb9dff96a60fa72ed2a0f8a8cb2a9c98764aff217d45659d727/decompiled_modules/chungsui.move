module 0xfde0b484ed840bb9dff96a60fa72ed2a0f8a8cb2a9c98764aff217d45659d727::chungsui {
    struct CHUNGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNGSUI>(arg0, 6, b"CHUNGSUI", b"EVM CHUNG", x"5a7569206368616e2066756e6465720a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5f091fa588112c116be45cd9b47f9addd53beb87fc9b1ffc2568428004f5bb59_chung_chung_fc943ecb8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

