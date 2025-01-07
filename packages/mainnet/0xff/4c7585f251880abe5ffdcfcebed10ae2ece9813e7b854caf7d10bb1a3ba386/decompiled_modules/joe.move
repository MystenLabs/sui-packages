module 0xff4c7585f251880abe5ffdcfcebed10ae2ece9813e7b854caf7d10bb1a3ba386::joe {
    struct JOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOE>(arg0, 6, b"Joe", b"Sui Chicken joe", x"4f6e6c79207375726665722066726f6d204c616b65204d6963686967616e200a53746f6e65720a57696e6e6572206f662054656e746820626967207a20616e6e75616c206d656d6f7269616c2073757266206f6666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3492_442607984d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

