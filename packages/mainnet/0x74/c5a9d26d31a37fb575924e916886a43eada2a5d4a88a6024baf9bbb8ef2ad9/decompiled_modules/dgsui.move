module 0x74c5a9d26d31a37fb575924e916886a43eada2a5d4a88a6024baf9bbb8ef2ad9::dgsui {
    struct DGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSUI>(arg0, 6, b"DGSUI", b"Doggy Sui", x"446f676779205355492032303234204f4e205355492024446f6767795375692054484520424c4f434b434841494e20444f474759204f4e205355492e2e2e204973206e6f772074616b656e206f76657220627920612043544f205465616d20544f4b454e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a9f91j3r9j10rk0fk0aof_eae010985e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

