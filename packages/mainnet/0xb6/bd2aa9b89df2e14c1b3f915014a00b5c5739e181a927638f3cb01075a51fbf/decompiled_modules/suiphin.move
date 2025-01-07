module 0xb6bd2aa9b89df2e14c1b3f915014a00b5c5739e181a927638f3cb01075a51fbf::suiphin {
    struct SUIPHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPHIN>(arg0, 6, b"SUIPHIN", b"Suiphin the Dolphin", b"Suiphin the Dolphin has gotten lost in the vast sea of Sui. Help him navigate the ecosystem and be rewarded with secret treasures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_9b0cb3b66f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

