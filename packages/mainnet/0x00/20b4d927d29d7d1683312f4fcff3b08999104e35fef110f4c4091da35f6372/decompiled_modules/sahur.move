module 0x20b4d927d29d7d1683312f4fcff3b08999104e35fef110f4c4091da35f6372::sahur {
    struct SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAHUR>(arg0, 9, b"SAHUR", b"tungtungtung", b"prev. cto leader deleted the tg group, but none can't stop tung tung tung sahur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DNrmDMs2czDaAwgzg2BmvM7Jn5ZqA6VN5huRqCrSpump.png?size=xl&key=f3e5b7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAHUR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHUR>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAHUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

