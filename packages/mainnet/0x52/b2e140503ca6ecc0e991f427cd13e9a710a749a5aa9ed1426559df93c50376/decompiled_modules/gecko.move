module 0x52b2e140503ca6ecc0e991f427cd13e9a710a749a5aa9ed1426559df93c50376::gecko {
    struct GECKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKO>(arg0, 6, b"GECKO", b"GECKO SUI", b"the official token of the Gecko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QYX_Ic_Ur_U_400x400_093733c28b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

