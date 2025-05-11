module 0x46dae3ea187fd4501ead4bdeacd9fc35f66f0ffc06d552e9bceec7d9379a287e::beni {
    struct BENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENI>(arg0, 6, b"Beni", b"Ben Dog", b"My dog Ben hes a good boy and eats stuff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0743_60686d882d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

