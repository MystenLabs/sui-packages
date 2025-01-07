module 0xab82cb48fc8a4ef31ab7eaedfd8d21f2e5b091606451c0a6179a1e398ad32b6f::doetoken {
    struct DOETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOETOKEN>(arg0, 6, b"DOEtoken", b"Dogs of Elon", b"The Dogs of Elon (DOE) is a community take-over project. Rug-pulled twice by evil forces, these dogs of war refuse to give up. No more teams, no more rugs, just a community of loyal dogs working together. The DOE mission is simple - to Mars and beyond. Fuck the jeets...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Pr8_E_Zu8_400x400_9f38b63528.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOETOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOETOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

