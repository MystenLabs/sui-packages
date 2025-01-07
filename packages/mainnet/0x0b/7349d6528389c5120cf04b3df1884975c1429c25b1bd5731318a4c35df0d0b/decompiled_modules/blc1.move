module 0xb7349d6528389c5120cf04b3df1884975c1429c25b1bd5731318a4c35df0d0b::blc1 {
    struct BLC1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLC1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLC1>(arg0, 6, b"BLC1", b"Proxima Centauri", x"424c43312028427265616b7468726f756768204c697374656e2043616e6469646174652031290a5120746865206d757369632e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blc1_a3167840ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLC1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLC1>>(v1);
    }

    // decompiled from Move bytecode v6
}

