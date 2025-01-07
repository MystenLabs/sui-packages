module 0x3cc900917e8f93290cee2c4695e09726022a26e0f44d25e0815a3b7cf7f987e4::grksi {
    struct GRKSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRKSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRKSI>(arg0, 6, b"GRKSI", b"GROKSUI", b"Grok SUI, thia ninja robot is a fan of the water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_G_Roke_robot_surfing_f7994d3dae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRKSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRKSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

