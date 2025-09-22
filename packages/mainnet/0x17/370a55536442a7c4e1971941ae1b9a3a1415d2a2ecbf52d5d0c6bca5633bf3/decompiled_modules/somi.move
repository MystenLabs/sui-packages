module 0x17370a55536442a7c4e1971941ae1b9a3a1415d2a2ecbf52d5d0c6bca5633bf3::somi {
    struct SOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMI>(arg0, 9, b"SOMI", b"Somnia on Sui", b"Somnia launch on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/xolZdbT")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMI>>(v2, @0x6932ff4b6bc0e50070d7150e3af0a49b89df85552fafb25aea5b666c45f25349);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

