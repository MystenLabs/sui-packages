module 0xad2d774e1d6498d26a396a4e43254b75e74dcf3ab5dfdd9c87376f2a53f974db::roshui {
    struct ROSHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSHUI>(arg0, 6, b"ROSHUI", b"Roshi", b"Pepe Roshi on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peperoshi12_74834fd2e8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

