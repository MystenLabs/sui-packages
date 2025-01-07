module 0x527400061077cf8b59b6b770e4ed17ce4c73247b0d49c577c9a02191d7497514::bread {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAD>(arg0, 6, b"BREAD", b"Bread Dolphin", b"The dolphin is made of bread.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bread_dolph_bb7f0c627a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

