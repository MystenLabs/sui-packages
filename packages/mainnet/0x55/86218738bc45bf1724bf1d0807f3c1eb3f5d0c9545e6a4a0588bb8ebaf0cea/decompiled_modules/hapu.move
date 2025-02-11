module 0x5586218738bc45bf1724bf1d0807f3c1eb3f5d0c9545e6a4a0588bb8ebaf0cea::hapu {
    struct HAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPU>(arg0, 6, b"HAPU", b"HAPPY PUPPY", b"HAPPIEST PUPPY EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_3fbb4d2090.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

