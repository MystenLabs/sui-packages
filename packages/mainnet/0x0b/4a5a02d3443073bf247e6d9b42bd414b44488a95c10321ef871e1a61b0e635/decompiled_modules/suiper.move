module 0xb4a5a02d3443073bf247e6d9b42bd414b44488a95c10321ef871e1a61b0e635::suiper {
    struct SUIPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPER>(arg0, 6, b"Suiper", b"Suiperman", b"Suiperhero of all suiperheroes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/superman_logo_blue_by_jt99jt_d49ayzx_375w_2x_71ac42f972.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

