module 0x2764ed5f008111dac9a81bda99f378a19c9820e006c8c6599e6cbd1ec025514b::duckai {
    struct DUCKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DUCKAI>(arg0, 6, b"DUCKAI", b"Donald Duck AI of SUI by SuiAI", b"A duck AI agent that will help you invest and manage your finances! CTO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ne_Y_IG_5_J_400x400_b74692ff7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

