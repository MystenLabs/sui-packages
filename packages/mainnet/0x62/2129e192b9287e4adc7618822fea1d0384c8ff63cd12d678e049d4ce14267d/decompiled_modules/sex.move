module 0x622129e192b9287e4adc7618822fea1d0384c8ff63cd12d678e049d4ce14267d::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 6, b"SEX", b"SUI Energy Xploit", b" Virtual mining on SUI! Build, mine, and earn $SEX tokens without the hardware.  Eco-friendly & fun. Join the #SUIEnergyXploit revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_24_9f6d19fcbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

