module 0x6189547dc1db31f11b81884bdf87996e03672729a7556713183811e7a07254bd::tmeow {
    struct TMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMEOW>(arg0, 6, b"TMEOW", b"TERMINAL MEOW", x"53595354454d20494e495449414c495a4154494f4e20200a5445524d494e414c20434154204e657572616c20426c6f636b636861696e2076392e303a2041435449564520200a5175616e74756d20576869736b6572733a2043414c4942524154454420200a5075727220456e67696e653a204f5054494d414c20200a4d617472697820436f6e6e656374696f6e3a2045535441424c495348454420200a43617420436f6e7363696f75736e6573733a204f4e4c494e4520200a53797374656d205374617475733a205245414459", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1729916606912_6c0718b49b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

