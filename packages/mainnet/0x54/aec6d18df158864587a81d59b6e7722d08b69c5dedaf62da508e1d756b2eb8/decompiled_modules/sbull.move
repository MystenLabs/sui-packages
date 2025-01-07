module 0x54aec6d18df158864587a81d59b6e7722d08b69c5dedaf62da508e1d756b2eb8::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUI BULL", x"2442756c6c27697368206f6e207468650a405375694e6574776f726b0a546865206669727374206d656d6520746f6b656e206f6e205355492077696c6c2062652062756c6c697368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y0t_C3_CBF_400x400_bc6753fdbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

