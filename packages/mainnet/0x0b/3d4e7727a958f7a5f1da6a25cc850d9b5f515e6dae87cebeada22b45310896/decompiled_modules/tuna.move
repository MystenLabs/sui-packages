module 0xb3d4e7727a958f7a5f1da6a25cc850d9b5f515e6dae87cebeada22b45310896::tuna {
    struct TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUNA>(arg0, 6, b"TUNA", b"TUNA TURNER", x"517565656e206f662074686520576174657220436861696e202454554e410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4o_3x9m_V_400x400_0b9cb02ed0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

