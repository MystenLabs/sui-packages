module 0x9f70a2e0e0553d8243235b847ddfca53bd00984502560000c7125b6a147653a1::aaaplop {
    struct AAAPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPLOP>(arg0, 6, b"aaaPLOP", b"AAAPLOP", b"AAAAPLOP Official by plop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000116141_59d54c4320.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

