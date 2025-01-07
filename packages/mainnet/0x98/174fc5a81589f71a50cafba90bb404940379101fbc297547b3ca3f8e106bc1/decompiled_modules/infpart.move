module 0x98174fc5a81589f71a50cafba90bb404940379101fbc297547b3ca3f8e106bc1::infpart {
    struct INFPART has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFPART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFPART>(arg0, 6, b"INFPART", b"Infrastructure partner", b"The infrastructure partner sold tokens worth $ 400 million, be like him, become him.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/orig_9901d275d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFPART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFPART>>(v1);
    }

    // decompiled from Move bytecode v6
}

