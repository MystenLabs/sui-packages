module 0xe399959e4e192538a856e1510fef6e85214f4ada0fc3f0a36f865f8fc215a2ed::rugman {
    struct RUGMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGMAN>(arg0, 6, b"RUGMAN", b"RUG MAN SUI", b"RUGMAN SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_O_Tw1_T0r_400x400_a1d0827c65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

