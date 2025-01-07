module 0xa13076d4baed8fb88f71fe7f1ed3d253440879b03c1c1ef241176ce52aba81e6::mom {
    struct MOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOM>(arg0, 6, b"MOM", b"YOURMOM", b"To all the SUI memecoin degens spamming my mentios, I have one pet and it's name is your mom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/header_e036374ed1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

