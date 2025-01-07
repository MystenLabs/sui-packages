module 0x31caa86f9b8ba695bb7f9d1ad4fee1e96b583d9e1d9fb54dc8d1eb57a60bf433::btcs {
    struct BTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCS>(arg0, 6, b"BTCs", b"Bitcoin on Sui", b"Bitcoin meme designed for cto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_f4ca6ddba2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

