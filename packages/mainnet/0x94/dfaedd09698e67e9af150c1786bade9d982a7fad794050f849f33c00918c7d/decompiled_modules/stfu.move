module 0x94dfaedd09698e67e9af150c1786bade9d982a7fad794050f849f33c00918c7d::stfu {
    struct STFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STFU>(arg0, 6, b"STFU", b"Shut The Fuck Up", b"shhhhh. can be a good project, can be a rugged. It's up to you M***** F****s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736598546918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STFU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

