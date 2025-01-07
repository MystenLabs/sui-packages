module 0xcdfd948b2529dcdf10c2f7c25526674209a1d3538ef29d4461e4f7e13693c9dd::blop {
    struct BLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOP>(arg0, 6, b"BLOP", b"BLOPFISH", b"bubbles on the oncean of SUI chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b24005333b8d0bf9391096f573ce4b4e_13b8e29960.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

