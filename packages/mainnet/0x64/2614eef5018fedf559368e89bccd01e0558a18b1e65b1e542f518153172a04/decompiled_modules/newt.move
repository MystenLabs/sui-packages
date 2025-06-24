module 0x642614eef5018fedf559368e89bccd01e0558a18b1e65b1e542f518153172a04::newt {
    struct NEWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWT>(arg0, 8, b"NEWT", b"Newton", x"43727970746f2055582069732062726f6b656e2e2041492063616ee280997420626520747275737465642e204e6577746f6e207365747320796f7520667265652e2053696d706c65722063727970746f20555820776974682076657269666961626c65204149206167656e74732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0cf86407-9913-41ca-b5cf-4cd3485db357.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEWT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEWT>>(v1);
    }

    // decompiled from Move bytecode v6
}

