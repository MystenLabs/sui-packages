module 0x9e9d06f26d25b9f5956b5c2d7287b12afb807e85f1bc71c7407d3678e27c8001::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"POCHITA", b"BLUE POCHITA", x"506f63686974612069732074686520736973746572206f662042616c6c747a652028434845454d5329200a0a426f6e6b27732073697374657220506f636869746120697320746865206e657720646f67206f6e2074686520626c6f636b20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3781_f4d906dd6c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

