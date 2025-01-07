module 0xf806053239458bc98d4a0404b14069614e75663d8b6348632a4ff59bde66ffd2::mcs {
    struct MCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCS>(arg0, 6, b"MCS", b"MacSui", b"MacSui: Because regular memes just cant handle this level of cool.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7a6c73734a109d1adec0e395461977b9_249a296997.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

