module 0x5aa402491a4fc058611a8e1dc3d6594d23ba9cdd838f35053809925b30d891e7::sci {
    struct SCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCI>(arg0, 6, b"SCI", b"SuiCatIce", b"Cat sluurrpp juicy ice cream in summer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008617_aa59d79c14.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

