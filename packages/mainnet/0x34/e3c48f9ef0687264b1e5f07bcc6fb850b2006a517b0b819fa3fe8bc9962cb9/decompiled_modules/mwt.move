module 0x34e3c48f9ef0687264b1e5f07bcc6fb850b2006a517b0b819fa3fe8bc9962cb9::mwt {
    struct MWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MWT>(arg0, 6, b"MWT", b"Maconer World Team", b"Macorner is a unique meme token born from a creative collaboration with the Print On Demand (POD) business model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/YH_55z5qe_400x400_1882d142e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MWT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

