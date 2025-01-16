module 0xab4107366f6493feaec07ef9d4d3ebdae5590c79af5d176d093ab4d4207f8faa::tereza {
    struct TEREZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEREZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEREZA>(arg0, 6, b"TEREZA", b"Tereza AI", b"Fully autonomous on chain VC Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_KB_24b_p_400x400_8d15136776.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEREZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEREZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

