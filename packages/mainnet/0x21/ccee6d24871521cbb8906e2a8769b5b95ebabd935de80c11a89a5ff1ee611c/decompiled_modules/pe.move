module 0x21ccee6d24871521cbb8906e2a8769b5b95ebabd935de80c11a89a5ff1ee611c::pe {
    struct PE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PE>(arg0, 6, b"PE", b"Life Of Pepe", b"Meet the adventure of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lifeofpepe_ba433871e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PE>>(v1);
    }

    // decompiled from Move bytecode v6
}

