module 0x8e9cb7ac171cec32e8be918b6e06bc261261a9163af3ee6702524cb4d70812f7::among {
    struct AMONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONG>(arg0, 6, b"AMONG", b"AMONG US", x"414d4f4e47205553205355490a414d4f4e47205553205355490a414d4f4e47205553205355490a414d4f4e47205553205355490a414d4f4e4720555320535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/freakmeaning_fre4k_33bcf2820c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

