module 0x38c1f83ebcf5d98913fa4fe24d4fecf94639074efffbe3c732b4839b2069415::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 6, b"Wewe", b"WEWE", b"Soon be going to be the first project on movepump to be listed on binance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wewe_49842b8c90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

