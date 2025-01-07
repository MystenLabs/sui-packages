module 0x97ac1469a475ab817abb1eca46fae09e6b3bd4497f493c33d85737ae4bb897f3::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 6, b"FRENS", b"Sui Frens", b"Sui Frens $FRENS are the official mascots of SUI designed and created by the developers of SUI themselves!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifrens_1027ca98fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

