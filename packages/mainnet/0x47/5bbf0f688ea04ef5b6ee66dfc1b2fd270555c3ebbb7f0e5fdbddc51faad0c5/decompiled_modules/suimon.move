module 0x475bbf0f688ea04ef5b6ee66dfc1b2fd270555c3ebbb7f0e5fdbddc51faad0c5::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 9, b"SUIMON", b"Sui Doraemon", b"Doraemon is a blue robotic cat from the future and comin into sui chain.   https://t.me/suidoraemon   https://www.suimon.fun/   https://x.com/suidoraemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729266674210-7575db7151f63821f5a2388d9b2a7912.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIMON>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

