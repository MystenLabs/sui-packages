module 0xafc77f58b26cc1e0e57810f0d860d240a5dd00a0c23115281de3ece35d1d985e::puf {
    struct PUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUF>(arg0, 9, b"PUF", b"Puffer Eat Carrot", b"Puffer Eat Carrot on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUF>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

