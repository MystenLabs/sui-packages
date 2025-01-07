module 0xf6f3f43581c8b6ce08d542c65a3ee6668f220dfd29871550849036a1ba922859::pbl {
    struct PBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBL>(arg0, 6, b"PBL", b"Peoble", b"Retro Gaming Platform on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/02_bf46c97d4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

