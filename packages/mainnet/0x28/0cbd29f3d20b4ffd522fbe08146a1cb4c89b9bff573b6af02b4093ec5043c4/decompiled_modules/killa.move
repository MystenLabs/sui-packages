module 0x280cbd29f3d20b4ffd522fbe08146a1cb4c89b9bff573b6af02b4093ec5043c4::killa {
    struct KILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLA>(arg0, 6, b"KILLA", b"KILLA THE WHALE", b"Killa has arrived on Sui to takeover the seven seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2222_min_f2a05ee1a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

