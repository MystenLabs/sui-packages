module 0x49379b667416467377be28b3b1c10c02077a9d008f86abe34fe719b872bd5ea6::hag {
    struct HAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAG>(arg0, 6, b"HAG", b"HAGIS", b"Introducing, Hagis, the rival of Moo Deng. What Moo Deng has done, Hagis will 100x it with your help. LFG! WAGMI! To the moon we go.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731217181951.07")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

