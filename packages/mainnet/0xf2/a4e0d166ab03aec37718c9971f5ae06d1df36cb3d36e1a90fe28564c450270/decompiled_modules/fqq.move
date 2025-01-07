module 0xf2a4e0d166ab03aec37718c9971f5ae06d1df36cb3d36e1a90fe28564c450270::fqq {
    struct FQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FQQ>(arg0, 6, b"FQQ", b"Hello", b"heworld ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/448300731_486669777270265_809316766956183801_n_ddaf591f35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FQQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FQQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

