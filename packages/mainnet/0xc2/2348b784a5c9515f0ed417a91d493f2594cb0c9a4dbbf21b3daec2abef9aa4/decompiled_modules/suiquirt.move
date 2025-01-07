module 0xc22348b784a5c9515f0ed417a91d493f2594cb0c9a4dbbf21b3daec2abef9aa4::suiquirt {
    struct SUIQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUIRT>(arg0, 6, b"SUIQUIRT", b"Suiquirt", b"We promise to suiquirt to investors ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/pfp_17be014d9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

