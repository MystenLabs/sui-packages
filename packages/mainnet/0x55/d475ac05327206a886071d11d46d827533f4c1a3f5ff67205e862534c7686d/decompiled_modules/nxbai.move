module 0x55d475ac05327206a886071d11d46d827533f4c1a3f5ff67205e862534c7686d::nxbai {
    struct NXBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NXBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NXBAI>(arg0, 6, b"NXBAI", b"Nex Bot Advance AI", b"Nexui Bot Advance Token Scanner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_01_7232639c32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NXBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NXBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

