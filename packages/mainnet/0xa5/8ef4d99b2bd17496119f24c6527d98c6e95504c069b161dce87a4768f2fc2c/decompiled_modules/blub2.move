module 0xa58ef4d99b2bd17496119f24c6527d98c6e95504c069b161dce87a4768f2fc2c::blub2 {
    struct BLUB2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB2>(arg0, 6, b"BLUB2", b"BLUB 2", x"496620796f75206d69737320626c7562207468697320697320796f7572207365636f6e74206368616e6365200a0a3130302520636f6d6d756e6974792064726976656e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_Tool_20240911235125_d908a533ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB2>>(v1);
    }

    // decompiled from Move bytecode v6
}

