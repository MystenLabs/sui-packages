module 0xe289fd226bf27b2fa2150503348eb97e98b115f4b345f713278e5b7478be4627::obpk {
    struct OBPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBPK>(arg0, 6, b"OBPK", b"Obi PNut Kenobi", x"0a4f626920504e7574204b656e6f62693a20546865206c6567656e64617279207065616e7574204a6564692c207769656c64696e672061206372756e636879206c69676874736162657220616e6420737072656164696e6720736e61636b2d73697a656420776973646f6d206163726f7373207468652067616c6178792e20486973206d6f74746f3f20224d617920746865206e7574206265207769746820796f75212220", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Z_Gbf_Aa_IAA_CQH_e3da2b6032.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

