module 0x26210c05a8b2d38bc43faf3fc597c89757fca2f159be045dc0a56f8855a05d12::sns {
    struct SNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNS>(arg0, 6, b"SNS", b"Super Nigger Saiyajin", b"First Super Nigger Saiyajin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SWUK_Stu_Vy7u26_G_Wob_Aw_MEZM_Hx7c_Vhq6yety_U_Fwkeh37g_befb4e86fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

