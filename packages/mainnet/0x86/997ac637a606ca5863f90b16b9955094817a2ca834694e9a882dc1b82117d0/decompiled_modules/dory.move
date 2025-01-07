module 0x86997ac637a606ca5863f90b16b9955094817a2ca834694e9a882dc1b82117d0::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"DORY", b"Dory", b"Finding Dory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sea_f8d6d33ef9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

