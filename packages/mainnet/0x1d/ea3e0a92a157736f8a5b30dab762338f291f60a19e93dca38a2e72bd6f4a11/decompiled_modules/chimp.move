module 0x1dea3e0a92a157736f8a5b30dab762338f291f60a19e93dca38a2e72bd6f4a11::chimp {
    struct CHIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIMP>(arg0, 6, b"CHIMP", b"ChimpanSui", b"ChimpanSui ($CHIMP) The wildest memecoin on the Sui blockchain!  Fast, fun, and community-driven, $CHIMP is all about jungle vibes and moon-bound energy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xc25503bf8fcccaa9723d58c32b7a371f2bc0e949d33e7880d1979d1af793b7ff_chimp_chimp_2988172369.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

