module 0x9a29d17ec2a4c7638cdc20dc2b1731ec3a86b03e5e78339e13d951721c285f7b::smokersui {
    struct SMOKERSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKERSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKERSUI>(arg0, 6, b"SMOKERSUI", b"SUISMOKER", b"SUISUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8wbb_O8_Nq_400x400_f7c8605bfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKERSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKERSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

