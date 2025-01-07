module 0x5d922a7b54b47039263a22db75283bdf7a947b2cc67d0e04a7811c5e15135cb4::suigloo {
    struct SUIGLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLOO>(arg0, 6, b"SUIGLOO", b"Gloo", b"Gloo the blue axolotl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gloopop_19f581f756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

