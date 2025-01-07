module 0x658392dd40097b9bd5450a956e90bcb99979a0742d831cdd96e666e394d6b6c5::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 9, b"ZZZ", b"LAZY", b"what", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZZZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

