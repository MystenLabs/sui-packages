module 0x7e34620ac85236b7f34ce016ff2049243d2f03982f1152061c7b5637c61c0044::bio {
    struct BIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIO>(arg0, 6, b"BIO", b"BIO", b"bioDAOs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.okx.com/cdn/web3/currency/token/501-AmtvMBMYtb5auN4KiFdMe9C8wjiu1KQZYQUL73Pw7ZZE-97.png/type=default_350_0?v=1734260043731&x-oss-process=image/format,webp/ignore-error,1"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIO>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

