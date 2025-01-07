module 0xf4a6d10059ddaf28d81311fa35a6e2a028e94dd9015bb9e08db5f1ce0204b6e1::trumpita {
    struct TRUMPITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPITA>(arg0, 6, b"TRUMPITA", b"Fagnald Trumpita", x"4d656574204661676e616c64205472756d70697461202d2074686520666167676965737420707265736964656e7420796f752077696c6c2065766572207365652e20200a200a42757420646f6e277420756e6465727374616e64207468656d2f74686579202d204661676e616c642069732068656c6c62656e74206f6e206f6e204d616b696e6720416d657269636120477265617420416761696e20616e642069732077696c6c696e6720746f2074616b65206d616368696176656c6c69616e20736368656d657320746f20646f20736f2e200a200a4661676e616c6420616e642074686569722067617920616c6c6965732072616c6c79696e67206f6e20535549206e6574776f726b20746f6461792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_24_03_33_21_e29dbbe861.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

