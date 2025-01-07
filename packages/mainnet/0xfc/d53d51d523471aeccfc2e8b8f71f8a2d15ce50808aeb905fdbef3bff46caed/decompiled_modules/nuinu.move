module 0xfcd53d51d523471aeccfc2e8b8f71f8a2d15ce50808aeb905fdbef3bff46caed::nuinu {
    struct NUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUINU>(arg0, 6, b"NUINU", b"Neuro Inu", x"49276d20746865206669727374206b696e64206f66206d696e6520696e20746865204e6575726f6e730a446f6e277420706c6179207468652067616d652e2e2e204920616d207468652067616d6520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_cd2375164a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

