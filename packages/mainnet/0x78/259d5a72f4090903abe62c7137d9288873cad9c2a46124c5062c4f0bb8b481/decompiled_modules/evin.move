module 0x78259d5a72f4090903abe62c7137d9288873cad9c2a46124c5062c4f0bb8b481::evin {
    struct EVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVIN>(arg0, 9, b"EVIN", b"EvinToken", b"A token created by Covert Llama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

