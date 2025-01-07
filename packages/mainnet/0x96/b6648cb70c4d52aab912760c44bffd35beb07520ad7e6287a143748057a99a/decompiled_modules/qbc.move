module 0x96b6648cb70c4d52aab912760c44bffd35beb07520ad7e6287a143748057a99a::qbc {
    struct QBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QBC>(arg0, 9, b"QBC", b"Quarterback Coin", b"kusrgflkjhbrglikubqerhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QBC>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

