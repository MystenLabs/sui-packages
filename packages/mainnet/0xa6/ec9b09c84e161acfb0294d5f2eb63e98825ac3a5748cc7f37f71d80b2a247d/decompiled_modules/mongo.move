module 0xa6ec9b09c84e161acfb0294d5f2eb63e98825ac3a5748cc7f37f71d80b2a247d::mongo {
    struct MONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGO>(arg0, 6, b"MONGO", b"Mongolo", b"Me like Sui. Me like water. Me be mongolo. Me proud mongolo. Me buy. Me hodl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitard_logo_68d477f383.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

