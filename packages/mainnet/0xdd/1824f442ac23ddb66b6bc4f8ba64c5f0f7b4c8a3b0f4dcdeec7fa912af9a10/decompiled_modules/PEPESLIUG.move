module 0xdd1824f442ac23ddb66b6bc4f8ba64c5f0f7b4c8a3b0f4dcdeec7fa912af9a10::PEPESLIUG {
    struct PEPESLIUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPESLIUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPESLIUG>(arg0, 6, b"PEPESLIUG", b"PEPESLIUG", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/PfGMvA2.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPESLIUG>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPESLIUG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPESLIUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

