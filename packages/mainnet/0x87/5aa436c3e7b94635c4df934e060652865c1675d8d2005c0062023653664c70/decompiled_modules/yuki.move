module 0x875aa436c3e7b94635c4df934e060652865c1675d8d2005c0062023653664c70::yuki {
    struct YUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUKI>(arg0, 9, b"YUKI", b"Sui Yuki", b"The girl on the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://prnt.sc/sAmR3C2VkIvI")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUKI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUKI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

