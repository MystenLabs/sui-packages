module 0x992c9e73fa82bfe446aebd0d258f1f8be66b0f2e900d4cd5b518103da05bbd91::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLASHY>(arg0, 6, b"SPLASHY", b"Splashy The Ghost", b"Splashy the ghost roams around the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Splashy_On_Sui_1_97ce16dfde.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLASHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

