module 0x18eae8d74737125845abe3544b9ef26f63f1cf46359fdda4d03b0fc08eed1f6c::meowdeng {
    struct MEOWDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWDENG>(arg0, 6, b"MeowDeng", b"Meow Deng", b"Meow Deng is a hippocatapuss for those wondering", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yv_Y1_LMXUA_Ay_Evz_c8de186bf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

