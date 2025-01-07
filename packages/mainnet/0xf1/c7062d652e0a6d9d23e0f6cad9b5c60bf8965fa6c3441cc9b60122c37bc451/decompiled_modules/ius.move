module 0xf1c7062d652e0a6d9d23e0f6cad9b5c60bf8965fa6c3441cc9b60122c37bc451::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"iuS", b".elbissecca dna ,eruces ,etavirp ,tsaf pihsrenwo tessa latigid ekam ot dengised mroftalp tcartnoc trams dna niahckcolb 1 reyaL dnik-sti-fo-tsrif a si iuS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8u_GG_Qmvkf_O_Dw7cnx3_Guek_Bb404_A2b_TY_Uc_Tj_Bkl_Hja_0a1d472442.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

