module 0x598b50be659c4ce3cea0e133645aa76a718bc34cde6f950d1556ff4598b33eba::qisan {
    struct QISAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: QISAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QISAN>(arg0, 6, b"QISAN", b"QISANMEI ON SUI", b"Oh my goshI really want to pet it ! This is Qi Sanmei, a panda baby born this year at Chongqing Zoo ! is being taken out by her caretaker to bask in the sun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_28171f83e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QISAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QISAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

