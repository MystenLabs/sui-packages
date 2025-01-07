module 0x1d1fd1b000a23ec398828d311317c9e6d5c630a3c71d95ab9a5d8119c4688356::suigt {
    struct SUIGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGT>(arg0, 6, b"SUIGT", b"suigt", x"530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000153_a16bca37f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

