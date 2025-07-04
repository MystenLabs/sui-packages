module 0xab7af1d3ce1287e0d08ba7864e1ccc7fc9c6296476437ad8ecc5b7f1f07c246f::eth_test {
    struct ETH_TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH_TEST>(arg0, 6, b"ETH-TEST", b"ETH-TEST", b"Ethereum Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://sandbox.fullsail.finance/static_files/ETH-TEST.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH_TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH_TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

