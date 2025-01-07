module 0x8ddcb75038586a248ab94db6172077b19f84d7edbafc2e21fcd8677f0a5e9b18::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 9, b"Biao Qing", b"BIAO", b"In reality, I am a BIAO... but everyone calls me BIAOQING. BIAOQING really likes this name, and BIAOQING loves everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=457,h=439,fit=crop/mxBZ5VDwz2HjBVJw/group-1-d95KPVx9xJhE4Pp9.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIAO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIAO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

