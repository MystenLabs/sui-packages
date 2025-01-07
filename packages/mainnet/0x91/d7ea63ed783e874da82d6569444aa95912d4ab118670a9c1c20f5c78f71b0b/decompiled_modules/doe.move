module 0x91d7ea63ed783e874da82d6569444aa95912d4ab118670a9c1c20f5c78f71b0b::doe {
    struct DOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOE>(arg0, 6, b"DOE", b"Dogs of Elon", b"The Dogs of Elon (DOE) is a community take-over project. Rug-pulled twice by evil forces, these dogs of war refuse to give up. No more teams, no more rugs, just a community of loyal dogs working together. The DOE mission is simple - to Mars and beyond. Fuck the jeets...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Pr8_E_Zu8_400x400_bbb104bbf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

