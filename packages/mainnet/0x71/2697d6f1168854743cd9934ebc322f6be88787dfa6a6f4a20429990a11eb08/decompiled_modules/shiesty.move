module 0x712697d6f1168854743cd9934ebc322f6be88787dfa6a6f4a20429990a11eb08::shiesty {
    struct SHIESTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIESTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIESTY>(arg0, 6, b"SHIESTY", b"Shiesty Cat", b"Shiesty is not your average cryptocurrency. It is a community-driven, no-nonsense meme coin with a playful edge and a serious purpose. Built on a secure blockchain and backed by a rapidly growing community of crypto enthusiasts, Shiesty brings together fun and functionality on Sui in a way that keeps people talking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfqzb10_NJ_Gtna_L2b_146e81956d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIESTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIESTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

