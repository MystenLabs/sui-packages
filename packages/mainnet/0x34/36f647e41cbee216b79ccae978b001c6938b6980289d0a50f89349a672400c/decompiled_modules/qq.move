module 0x3436f647e41cbee216b79ccae978b001c6938b6980289d0a50f89349a672400c::qq {
    struct QQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQ>(arg0, 6, b"Qq", b"QQ", b" I'm QQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYTL_Ojak_AA_2_Mf_Z_69f8d2d32b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

