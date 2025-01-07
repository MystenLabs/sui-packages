module 0xd5fc3cb33c6361d624e009c27d1d22ac5a64df13fade7b618801dd684b21c89f::duckzilla {
    struct DUCKZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZILLA>(arg0, 6, b"DUCKZILLA", b"Duckzilla on Sui", b"Duckzilla on Sui is slow, but its coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_1_1_d8450e3ab6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

