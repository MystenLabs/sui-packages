module 0x7d0ef57fe0b39566e3fbd10920198a7e1079e86caf6a17d6f03ea76dfc011bc::anus {
    struct ANUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANUS>(arg0, 6, b"ANUS", b"PrepareYourAnus", x"4675636b696e67207363616d6d657273206e65656420746f204655434b204f46462e20496620492066696e6420796f752c20492077696c6c2072697020796f757220416e7573206170617274210a0a68747470733a2f2f70726570617265796f7572616e75732e7774662f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prepare_your_anus009_b338a91521.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

