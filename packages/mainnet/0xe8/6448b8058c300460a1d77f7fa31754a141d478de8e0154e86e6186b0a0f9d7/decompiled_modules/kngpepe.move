module 0xe86448b8058c300460a1d77f7fa31754a141d478de8e0154e86e6186b0a0f9d7::kngpepe {
    struct KNGPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNGPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNGPEPE>(arg0, 6, b"KNGPEPE", b"King Pepe", b"King Pepe is a leader who always stands strong and determined, overcoming every challenge with a smile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/70171845_52e3_4292_b770_8501e818879e_85b2c4e87d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNGPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNGPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

