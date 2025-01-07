module 0x8ecb61e0cf80133f164118eea9a938e29aea8b53b81df2ab3c968a64024b71f7::bingus {
    struct BINGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGUS>(arg0, 6, b"BINGUS", b"Bingus The Cat", b"they really put bingus on the sui block chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Jy34_Zwd_400x400_cd3ee9757d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

