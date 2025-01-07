module 0xf086dd3e702177f52eb31e0ce51f7a8b012534705ad949232136e812f4334ba2::snkl {
    struct SNKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNKL>(arg0, 6, b"SNKL", b"SNEAKY OWL", b"You didnt come this far to stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_033846397_c67f10b650.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

