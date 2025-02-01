module 0xb18187c7990ca054e833da896959a73381f92f02d5bbf9589288c2942b8620c6::alpaca {
    struct ALPACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPACA>(arg0, 9, b"ALPACA", b"Alpaca", b"First Bitcoin Mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme7gZgmy296QXN6oityLpj4VtWMpQmvBsW9USa8PCnCth")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALPACA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPACA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPACA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

