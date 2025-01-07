module 0x3a748a501e3c484ec848d43b8df0eecee865939c62b8e1f76aa8b3c05cd45363::bbnb {
    struct BBNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBNB>(arg0, 6, b"BBNB", b"BabyBNB", x"0a496e74726f647563696e672042616279424e422c20746865206e65776573742c2074696e696573742028796574206d696768746965737429206d656d626572206f66207468652053554920436861696e2066616d696c79210a0a42616279424e42206973206d6f7265207468616e206a7573742061646f7261626c65206272616e64696e67697427732074686520706c617966756c2066616365206f6620612076696272616e7420616e642067726f77696e672053554920436861696e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5451883339691712865_c_f5f4d4ba65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

