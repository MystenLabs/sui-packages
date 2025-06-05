module 0x31b064aded95f269c952bdd20830abb18135b2ecaa7271bab289cf66619bc318::rwaves {
    struct RWAVES has drop {
        dummy_field: bool,
    }

    fun init(arg0: RWAVES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RWAVES>(arg0, 6, b"Rwaves", b"Room Waves ", x"696e2064697367756973650ae28094206120626c656e64206f66206368696c6c20616e64206a617a7a7920626561747320746f2068656c7020796f752073747564792c20776f726b2c206f7220756e77696e642e20456e6a6f7920f09f91bbf09f90b10a0a2d0a68747470733a2f2f6f70656e2e73706f746966792e636f6d2f6172746973742f30567733396e5461673054355241503675565437464e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749081829888.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RWAVES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RWAVES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

