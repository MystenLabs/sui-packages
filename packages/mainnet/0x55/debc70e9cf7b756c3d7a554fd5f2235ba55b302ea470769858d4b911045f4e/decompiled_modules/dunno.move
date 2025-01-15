module 0x55debc70e9cf7b756c3d7a554fd5f2235ba55b302ea470769858d4b911045f4e::dunno {
    struct DUNNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUNNO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DUNNO>(arg0, 6, b"DUNNO", b"DUNNO MEMES AI by SuiAI", b"bringing back meme culture on .sui network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/c1_g5e6c_400x400_ff7051be12.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUNNO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUNNO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

