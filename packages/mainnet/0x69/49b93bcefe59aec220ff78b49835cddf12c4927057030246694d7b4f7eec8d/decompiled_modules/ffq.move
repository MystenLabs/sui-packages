module 0x6949b93bcefe59aec220ff78b49835cddf12c4927057030246694d7b4f7eec8d::ffq {
    struct FFQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFQ>(arg0, 6, b"FFQ", b"Fat Fart Queen", x"466174204661727420517565656e2028464651290a596f75206c6f7665206d652e2e20726967687420616e6f6e3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wtwert_86a1446c32.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

