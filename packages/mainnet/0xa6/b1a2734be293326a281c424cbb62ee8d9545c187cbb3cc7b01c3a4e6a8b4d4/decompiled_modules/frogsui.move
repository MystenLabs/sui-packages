module 0xa6b1a2734be293326a281c424cbb62ee8d9545c187cbb3cc7b01c3a4e6a8b4d4::frogsui {
    struct FROGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGSUI>(arg0, 6, b"FROGSUI", b"Frogsui", b"Frog~ frog--", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241012_033552_74fbfe90c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

