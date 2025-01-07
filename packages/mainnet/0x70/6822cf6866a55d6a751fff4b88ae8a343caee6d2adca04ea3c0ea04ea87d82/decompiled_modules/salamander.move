module 0x706822cf6866a55d6a751fff4b88ae8a343caee6d2adca04ea3c0ea04ea87d82::salamander {
    struct SALAMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALAMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALAMANDER>(arg0, 6, b"SALAMANDER", b"Salamander Sui", b"Sal is a slimy salamander that will slither its way to the top of Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sala_9de3a3c894.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALAMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALAMANDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

