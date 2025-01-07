module 0x68959f9d9ff3dafb8f5bb26703997990277c2b6e49436cbe84b7d11425f707b6::kibi {
    struct KIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIBI>(arg0, 6, b"KIBI", b"Acid Frog", b"$KIBI the Acid Frogs is the little brother of Pepe the Frog. Both of them are beloved Frogs that created by the legend, Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_Pyv_A8_Fh_400x400_a7a8578dfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

