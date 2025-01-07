module 0xd144083f15732f191b38194f2010f4d8352104e00f6e6c65509ede7305311795::btc2009 {
    struct BTC2009 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC2009, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC2009>(arg0, 6, b"BTC2009", b"FIRST BITCOIN", b"Bitcoins logo, featuring BC engraved on a gold coin, aims to mimic physical currency functionality, showcasing the brands ability to function similarly to physical currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jqpd_A5_Vf_400x400_1cfac10cf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC2009>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC2009>>(v1);
    }

    // decompiled from Move bytecode v6
}

