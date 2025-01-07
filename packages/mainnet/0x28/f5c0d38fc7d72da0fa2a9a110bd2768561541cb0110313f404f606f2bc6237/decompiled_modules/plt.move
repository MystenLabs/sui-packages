module 0x28f5c0d38fc7d72da0fa2a9a110bd2768561541cb0110313f404f606f2bc6237::plt {
    struct PLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLT>(arg0, 6, b"PLT", b"PLUTO MEME", b"From the icy edge of the solar system to the fiery depths of your portfolio. Pluto Meme is cold AF and ready to moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_015747746_98b69af1b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

