module 0x8f80ac41494144e853968b92b23048d6126c31301972024157f3c9e578611011::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 6, b"OMG", b"Omg", b"Oh my Gat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/omg_cropped_8f9a8963d0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

