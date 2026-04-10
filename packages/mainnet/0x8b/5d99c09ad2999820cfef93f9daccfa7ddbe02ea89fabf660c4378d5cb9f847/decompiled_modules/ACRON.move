module 0x8b5d99c09ad2999820cfef93f9daccfa7ddbe02ea89fabf660c4378d5cb9f847::ACRON {
    struct ACRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACRON>(arg0, 10, b"ACRON", b"ACRON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/csznj10/ARCON.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ACRON>(&mut v2, 200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACRON>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

