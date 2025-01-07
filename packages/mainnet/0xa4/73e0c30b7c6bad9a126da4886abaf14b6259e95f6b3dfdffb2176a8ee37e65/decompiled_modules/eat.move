module 0xa473e0c30b7c6bad9a126da4886abaf14b6259e95f6b3dfdffb2176a8ee37e65::eat {
    struct EAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAT>(arg0, 6, b"EAT", b"Eating Cats", b"They're eating the dogs, the people that came in, they're eating the cats. They're coming for you aaa cat. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eating_the_cats_7c1c744fbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

