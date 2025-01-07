module 0x5beb7a4865b427c2e97d111b1753316d19e50c5f142224ba8cd50e732d7afd55::pinkpig {
    struct PINKPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKPIG>(arg0, 6, b"PINKPIG", b"Pink Sui Pig", x"59616c6c2c202450494e4b5049472069732074686520756c74696d617465207669626520636865636b20666f72206d656d6520636f696e7321200a0a436c69636b2062656c6f7720746f2076657269667920796f752772652068756d616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016707_fa5621fe68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

