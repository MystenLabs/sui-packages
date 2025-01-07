module 0xd535882686ef910d6600276ac1b88fa2502dc3cd7d13effbe440ae8752e89aee::crp {
    struct CRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRP>(arg0, 8, b"CRP", b"CRP", b"CRPRP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733169107&X-Expires=315360000&X-Method=GET&X-Signature=4f9463f202395176e092a45e63937f5791c79e4c91380177e741ee72b1f43aab"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CRP>>(v2);
    }

    // decompiled from Move bytecode v6
}

