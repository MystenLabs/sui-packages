module 0x3668a14dd4382bf26394759fb6f2c5733180e41f4a75c827f8d49976699049a5::szc {
    struct SZC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZC>(arg0, 6, b"SZC", b"Suizcanal", b"The token is memed after famous suez canal in Egypt which is more than 190KMs long and generate more than 10 billion USD in revenues. The token(sui'z-canal) is aimed to replicate the trading volume of suez canal in SUI ecosystem which itself is no less than a digital Suez canal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030357_3302c75adc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZC>>(v1);
    }

    // decompiled from Move bytecode v6
}

