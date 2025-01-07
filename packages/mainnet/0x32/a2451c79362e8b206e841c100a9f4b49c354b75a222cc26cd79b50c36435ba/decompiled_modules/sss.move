module 0x32a2451c79362e8b206e841c100a9f4b49c354b75a222cc26cd79b50c36435ba::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"SALLY THE SUINAMI SURFER", b"No one can stand against the waves, you have to ride them. Lets ride the waves of Suinami together$$$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/152d0fd2_221d_4c5e_aefe_89ce050a4e84_1_6f42766518.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

