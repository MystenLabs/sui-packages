module 0xdbf30747b8987c5efddbe99c5059c5c1d48635531bd7adf92953e3dcc6541e00::nyamoto {
    struct NYAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYAMOTO>(arg0, 6, b"NYAMOTO", b"Nyan Bit", b"Introducing $NYAMOTO: where Satoshi Nakamoto meets the internets favorite rainbow cat! Get ready to ride the blockchain with a sprinkle of nostalgia and a whole lot of meme magic. Hop on the $NYAMOTO rocketbecause who said crypto cant be cute and quirky? Let's chase those gains across the cosmic internet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmam_J_Syigns_R5e_Agq_AY_9_Vrrfsy5_NLTDT_Ea_L1e_G_Lduisxw_A_3394cf24a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYAMOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

