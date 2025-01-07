module 0xd2454d5d5fcd749789ba35f2c5ba775a0a1a2098fbb1c449c13255d0db930828::mrc {
    struct MRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRC>(arg0, 9, b"MRC", b"Marco", b"Marco's token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MRC>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

