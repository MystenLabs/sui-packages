module 0x4011f478f89b9bd8f125157543663fb106816701d33c980d3cc62106755b0c9::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 6, b"SML", b"smile", b"one collection", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fox_0a25b195c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

