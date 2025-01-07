module 0xd35e45c9371b288a96881fc573a51ebc93140258359ed252629386a75604a761::castro {
    struct CASTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASTRO>(arg0, 6, b"Castro", b"SuiCastro", x"4920676f74206d61727269656420746869732070617374207765656b656e6420746f206d79206c6f6e67207465726d20706172746e657220616e64206265737420667269656e642c20416e67656c61204d656e67212043616e74207761697420746f206275696c642061206c69666520746f6765746865722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241010011619_a3038cdcec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

