module 0x4324c6a364f544c0cc13533ba5261d4f26f08dee98330b42cae71b6f70851c01::suifar {
    struct SUIFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFAR>(arg0, 6, b"SUIFAR", b"SuiFar", b"$SUI - A legendary character inspired by Matt Furie's Boy's Club comic. The red mascot of the Sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0m_WJ_Sk_HI_400x400_a65d7d832c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

