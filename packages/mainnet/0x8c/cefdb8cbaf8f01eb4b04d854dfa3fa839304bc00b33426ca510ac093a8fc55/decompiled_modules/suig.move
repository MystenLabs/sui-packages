module 0x8ccefdb8cbaf8f01eb4b04d854dfa3fa839304bc00b33426ca510ac093a8fc55::suig {
    struct SUIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIG>(arg0, 6, b"SUIG", b"Sui Gallerie", b"Welcome to Suigallerie Empowering You in the SUI Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uf_Y_Vmow_U_400x400_9adb01739e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

