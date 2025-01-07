module 0xca060a8e89010f279e7f35a5a4f44f9cc92cb47a7c8e691e85ec412af3f43ebc::quantrug {
    struct QUANTRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTRUG>(arg0, 6, b"QUANTRUG", b"QUANT RUGGUY", b"so $Quant is official and $Rugguy is its meme?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gczvo0v_X0_A_Ahjyy_a3d6654ec9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANTRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

