module 0xacef0f85a5bf6a14cd38803f99c217f88c52e67fde306d6af3af61b02ab7209e::tg {
    struct TG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TG>(arg0, 9, b"TG", b"TOP G", b"TOP G Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TG>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TG>>(v1);
    }

    // decompiled from Move bytecode v6
}

