module 0xf076acd02d16b33cce7d2bb57a6e31a89fb932f4256f56a3253207fae0d23524::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 9, b"BLB", b"BLBUL", b"official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/097fa2c64c88da13bdd9420c848596aablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

