module 0xfa54e9e58716672f2434fb7fc690f1dedf8b5c3132ee4aef3e294dba1dbff416::suitc3 {
    struct SUITC3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITC3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITC3>(arg0, 9, b"SUITC3", b"Sui Test Coin3", b"Test coin3 for SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITC3>(&mut v2, 2000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITC3>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITC3>>(v1);
    }

    // decompiled from Move bytecode v6
}

