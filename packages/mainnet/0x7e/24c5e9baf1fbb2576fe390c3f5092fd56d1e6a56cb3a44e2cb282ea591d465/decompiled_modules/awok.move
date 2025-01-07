module 0x7e24c5e9baf1fbb2576fe390c3f5092fd56d1e6a56cb3a44e2cb282ea591d465::awok {
    struct AWOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWOK>(arg0, 5, b"AWOK", b"Awokwokwok", b"Awokwokwok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/nV1sY59P/wwwwwww.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AWOK>(&mut v2, 9110000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

