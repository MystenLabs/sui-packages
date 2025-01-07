module 0x472852527d504eff3a594de71ebc3164dd4f0da3cb682137bfce46ddaa635088::dile {
    struct DILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILE>(arg0, 6, b"Dile", b"Bluebluedile", b"Bluebluedile, the crocodile king of Sui, guards and grows $Dile. Dive in with $Dile, the top predator, to reclaim our throne and revive relics.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/android_chrome_192x192_10308d5f1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

