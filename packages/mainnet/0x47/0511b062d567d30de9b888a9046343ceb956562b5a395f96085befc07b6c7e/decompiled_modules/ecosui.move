module 0x470511b062d567d30de9b888a9046343ceb956562b5a395f96085befc07b6c7e::ecosui {
    struct ECOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECOSUI>(arg0, 6, b"Ecosui", b"ECOSUISTEM", x"45434f5355495354454d20697320616e20696e6e6f766174697665204e4654206d61726b6574706c61636520616e6420646563656e7472616c697a6564206170706c69636174696f6e20286441707029206275696c74206f6e207468652053756920426c6f636b636861696e2e0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241014_233409_904_24dd18000c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

