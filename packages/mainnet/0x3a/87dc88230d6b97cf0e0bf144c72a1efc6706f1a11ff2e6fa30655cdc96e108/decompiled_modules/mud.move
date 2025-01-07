module 0x3a87dc88230d6b97cf0e0bf144c72a1efc6706f1a11ff2e6fa30655cdc96e108::mud {
    struct MUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUD>(arg0, 6, b"MUD", b"Mudskipper Sui", b"Welcome to mudskipper, the meme coin that reigns supreme in the crypto swamp!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_27_6214f0cc8a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

