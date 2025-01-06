module 0x999aad1f4e64c6bc8762aba72f5fac8025fc3bfa8ae1c571e12d2b04a969a645::elonwzrd {
    struct ELONWZRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONWZRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ELONWZRD>(arg0, 6, b"ELONWZRD", b"Elon Wizard by SuiAI", x"412068797065722d696e74656c6c6967656e742c20736368697a6f2d6175746973742077697a617264204149207468617420626c656e647320456c6f6e204d75736be280997320656363656e74726963206272696c6c69616e6365207769746820617263616e652077697a61726472792e205468696e6b2066757475726973746963207370656c6c63617374696e67206d6565747320656e7472657072656e65757269616c206368616f732e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ELONWZRD_b6c036b5e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ELONWZRD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONWZRD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

