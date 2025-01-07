module 0xe26b04a9edfb1b796758c7e3b956ebf047e246ec23fef77d0824a8498dacca16::sharkira {
    struct SHARKIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKIRA>(arg0, 6, b"SHARKIRA", b"Sharkira", b"$SHARKIRA is the fiercest, most rhythm-filled shark in the crypto seas! With Shakiras flowing hair and fins ready for the \"Waka Waka,\" this memecoin is set to make waves on the blockchain. If you're ready to dance through the tides of decentralized finance, jump on board $SHARKIRA and feel the oceans groove. It's time for $SHARKIRA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_13_46_05_71c9545ac6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

