module 0x2c9e666ce80ba8461094a645619eb7f99f5847293a65c0682696d7e6f881d5bf::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 6, b"ADAM", b"ADAM BUNNY", x"244144414d2074686520626c7565207261626269742c20697320726561647920746f207475726e20757020746865206368616f73206f6e205375692e0a0a546865206d6f6e6579207072696e7465722069732061206d616e6961632120425252525252520a6164616d62756e6e792e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/456546889_796c99cf03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

