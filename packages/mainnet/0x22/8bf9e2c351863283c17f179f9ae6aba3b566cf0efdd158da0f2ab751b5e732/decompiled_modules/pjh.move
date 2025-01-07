module 0x228bf9e2c351863283c17f179f9ae6aba3b566cf0efdd158da0f2ab751b5e732::pjh {
    struct PJH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJH>(arg0, 8, b"PJH", b"PJH", b"NewStar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733203660&X-Expires=315360000&X-Method=GET&X-Signature=b322ba8fa051a1e17d6564ed2ecab6978bd6add4756199017fd6f2ff5358d8f6"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PJH>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PJH>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PJH>>(v2);
    }

    // decompiled from Move bytecode v6
}

