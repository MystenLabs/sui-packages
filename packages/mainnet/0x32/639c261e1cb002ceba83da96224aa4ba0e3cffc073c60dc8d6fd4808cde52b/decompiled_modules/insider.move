module 0x32639c261e1cb002ceba83da96224aa4ba0e3cffc073c60dc8d6fd4808cde52b::insider {
    struct INSIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSIDER>(arg0, 6, b"INSIDER", b"Infrastructure Partners", b"Seeming we only spent $400m worth of SUI, we need more of your money so buy our token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/infra_833349330f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INSIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

