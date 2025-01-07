module 0xbb6dc948b649bc7ddcccd13b88379f4485aa9ba0fa217bee822929aafca0b22b::bibble {
    struct BIBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBBLE>(arg0, 6, b"BIBBLE", b"Bibble on Sui", x"424942424c452061696d7320746f2072616c6c7920610a636f6d6d756e697479206f6620656e7468757369617374730a616e6420737570706f72746572732077686f0a62656c6965766520696e20746865206d697373696f6e2e2042790a737461636b696e6720796f757220627265616420696e0a424942424c452020796f75206172656e2774206a7573740a696e76657374696e6720696e20616e6f74686572206d656d650a636f696e20796f752077696c6c206265206a6f696e696e6720610a6d6f76656d656e7420746f2068656c7020424942424c450a6d616b6520697420686f6d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042412_67849a2040.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

