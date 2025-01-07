module 0x2f087e9320eb48d79b81d1793001ebbd02a9a3650978eb431cae4a18990c1468::hos {
    struct HOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOS>(arg0, 6, b"HOS", b"Hoppyonsui", b"Happy Hoppy Rabbit on #Suinetwork ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_5e09b146dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

