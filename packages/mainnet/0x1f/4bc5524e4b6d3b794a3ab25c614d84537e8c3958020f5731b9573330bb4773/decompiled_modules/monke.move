module 0x1f4bc5524e4b6d3b794a3ab25c614d84537e8c3958020f5731b9573330bb4773::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"MONKE", b"MONKE.BOX", b"$Monke on #Move : The fastest Monke in the jungle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_04_20_00_26_7f4f1272fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

