module 0xa76c3ca6f708a81401be264034aebce0bff9a49f6e6b2182d7c5a8b0fe24c16e::sirius {
    struct SIRIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIRIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIRIUS>(arg0, 9, b"SIRIUS", b"First Bitcoin Cat", b"First Bitcoin Cat Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1788033720213-e03b76903a1fcbe7c2763acc1e55435f.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SIRIUS>>(0x2::coin::mint<SIRIUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIRIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIRIUS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

