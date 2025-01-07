module 0x8ebd0c724e35a131f4279c4e425fa8ea21940360976316ced0eaf70f87010f7b::mistycto {
    struct MISTYCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTYCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTYCTO>(arg0, 6, b"MISTYCTO", b"Misty CTO", b"Community better than fucking dev", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_VKZK_2_CI_400x400_1246212460_d0224ab123.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTYCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTYCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

