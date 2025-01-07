module 0x37fa35366fb7ba0d20be0986628e7b7dba80dca0d5b5180a4bd9cd8169720871::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKY>(arg0, 6, b"BLINKY", b"SUI BLINKY", b"3 eyes as 3 letters in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3eye_bdfb0c505d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

