module 0xc2254cdfc27a16cdd5f61c1eac8cba301d5971fd6d5f32fc83aa52afb69b20f4::saltwater {
    struct SALTWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALTWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALTWATER>(arg0, 6, b"SALTWATER", b"Saltwater on Sui", b"SALTWATER MAKING WAVES ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaa_AAAA_Aaaa_AA_Aaa_AAA_Aaa_A_Aaa_A_5_c69635719f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALTWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALTWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

