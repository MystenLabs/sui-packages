module 0x14c4c7583dbb1cb453f78d7f7a9057015abcbcc17affa4a32fba845a59c8a98f::kackle {
    struct KACKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KACKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KACKLE>(arg0, 6, b"Kackle", b"The Kackler", b"A President you can get behind to serve the White House and American people so she can get ahead and screw you over.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_f20bada352.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KACKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KACKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

