module 0x1aea373343e431e00d5604fc8667d63eadc0ff7622d08d34cba3fd94530f96c::dangs {
    struct DANGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANGS>(arg0, 6, b"DANGS", b"DangSUI", x"48692c20496d2044414e47212c2050656e672773206265737420667269656e64202d2050656f706c652074656c6c206d652049206c6f6f6b206c696b6520506570652e20492074656c6c207468656d20496d2061204475636b206f6e20746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_190038_557_9314fc56bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

