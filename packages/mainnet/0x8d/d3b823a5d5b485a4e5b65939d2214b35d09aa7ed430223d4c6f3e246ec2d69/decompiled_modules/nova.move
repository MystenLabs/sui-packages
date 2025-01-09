module 0x8dd3b823a5d5b485a4e5b65939d2214b35d09aa7ed430223d4c6f3e246ec2d69::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"Suipernova", x"5375697065726e6f766120697320746865206d6f737420706f77657266756c206578706c6f73696f6e206b6e6f777320746f206d616e6b696e642c206974277320676f6e6e61206c69676874207570207468652077686f6c6520535549206e6574776f726b2061667465722069742068697473204445580a47657420757273656c662061207069656365206265666f726520697420646f657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_12_181924bc82.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

