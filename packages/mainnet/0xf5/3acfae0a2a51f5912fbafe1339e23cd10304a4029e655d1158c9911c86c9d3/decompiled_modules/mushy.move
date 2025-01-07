module 0xf53acfae0a2a51f5912fbafe1339e23cd10304a4029e655d1158c9911c86c9d3::mushy {
    struct MUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSHY>(arg0, 6, b"MUSHY", b"Mushy Sui", b"Mushy is just a fungi looking for some fungis on their TRIP to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul60_20250102215518_9e40cf9fec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

