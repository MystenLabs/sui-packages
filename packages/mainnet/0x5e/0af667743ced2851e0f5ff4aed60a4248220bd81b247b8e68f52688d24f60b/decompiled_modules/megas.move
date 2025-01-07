module 0x5e0af667743ced2851e0f5ff4aed60a4248220bd81b247b8e68f52688d24f60b::megas {
    struct MEGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGAS>(arg0, 6, b"MEGAS", b"MEGA Sui Gang", b"We are going to be MEGA HUGE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5906_b2d129a3d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

