module 0xf3020140498c98c5726001de6aeed645af4de1afc1397f9187b5e68004cc7549::durqa {
    struct DURQA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DURQA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DURQA>(arg0, 9, b"durqa", b"Durqa Puja", x"4d6179207468697320666573746976616c206272696e6720796f7572206c6966652066696c6c65642077697468206a6f7920616e642074686520737472656e67746820746f20747269756d7068206f76657220616c6c20746865206368616c6c656e6765732e2057697368696e6720796f7520746f20626520737572726f756e646564206279207468656d2077686f206272696e677320796f75206a6f7920616e642070726f7370657269747921202053656e64696e6720796f75206120686561727466656c742077697368657320666f72206120626c657373656420616e64206a6f7966756c2044757267612050756a6120f09f9290", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/17015367/file/original-c4df9b81ccae98af7ee20897ac287886.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DURQA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DURQA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DURQA>>(v1);
    }

    // decompiled from Move bytecode v6
}

