module 0x9516ee0efb0b1b9ab53aad28833396dc445fce62985d1a406ef7a368d6edda11::qqq {
    struct QQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ>(arg0, 5, b"QQQ", b"qqq", b"qqq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733206361&X-Expires=315360000&X-Method=GET&X-Signature=55ffb861b96a3dad4ad3b71b40634ea1dc91d8a01e9771919f0701b8e5ceab6a"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QQQ>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QQQ>>(v2);
    }

    // decompiled from Move bytecode v6
}

