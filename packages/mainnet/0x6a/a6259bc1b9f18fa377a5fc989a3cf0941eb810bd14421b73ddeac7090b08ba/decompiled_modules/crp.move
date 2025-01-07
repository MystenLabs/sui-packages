module 0x6aa6259bc1b9f18fa377a5fc989a3cf0941eb810bd14421b73ddeac7090b08ba::crp {
    struct CRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRP>(arg0, 9, b"CRP", b"CRP", b"This is a CRP test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733167642&X-Expires=315360000&X-Method=GET&X-Signature=152542400a9515cea4cbe7971b02403b216476f283f53dd8caf85a3b54a1c46c"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CRP>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CRP>>(v2);
    }

    // decompiled from Move bytecode v6
}

