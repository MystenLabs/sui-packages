module 0xf1b0895268d326b6f4b7e53ea6d9a68529e54e42b8e4c71ec30245c82f5a2e28::suiscam {
    struct SUISCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISCAM>(arg0, 6, b"SUISCAM", b"SUI SCAM", b"I think the #suiscam tag that first appeared about Sui should go down in history as a meme. At this point, Sui has accomplished very good things. I will burn the tokens and it will become CTO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUISCAM_d0f9caee30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

