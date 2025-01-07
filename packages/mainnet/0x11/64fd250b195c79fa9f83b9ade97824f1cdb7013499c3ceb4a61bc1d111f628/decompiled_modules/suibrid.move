module 0x1164fd250b195c79fa9f83b9ade97824f1cdb7013499c3ceb4a61bc1d111f628::suibrid {
    struct SUIBRID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBRID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBRID>(arg0, 6, b"SUIBRID", b"SuiBridge Bot", x"537569427269646765626f7420697320612063726f73732d636861696e20627269646765206275696c7420666f722053756920626c6f636b636861696e2c20656e61626c696e67207365616d6c657373206173736574207472616e7366657273206265747765656e206d616a6f7220626c6f636b636861696e73206c696b6520457468657265756d2c20536f6c616e612c204253432c20616e64206d6f72652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Bridge_Bot_fa88ae72c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBRID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBRID>>(v1);
    }

    // decompiled from Move bytecode v6
}

