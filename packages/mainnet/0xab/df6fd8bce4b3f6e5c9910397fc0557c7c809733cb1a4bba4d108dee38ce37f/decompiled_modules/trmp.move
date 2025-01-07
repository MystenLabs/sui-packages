module 0xabdf6fd8bce4b3f6e5c9910397fc0557c7c809733cb1a4bba4d108dee38ce37f::trmp {
    struct TRMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMP>(arg0, 6, b"TRMP", b"TrumpCoin on SUI", x"5472756d70436f696e202854524d5029202d2074686520746f6b656e2074686174207361797320596f7572652048697265642120746f20746865206d656d65206d61726b6574210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yra_EAF_Vv_400x400_0e27ad592a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

