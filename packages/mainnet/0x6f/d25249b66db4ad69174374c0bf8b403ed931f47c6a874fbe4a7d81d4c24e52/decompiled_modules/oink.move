module 0x6fd25249b66db4ad69174374c0bf8b403ed931f47c6a874fbe4a7d81d4c24e52::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"OinkSui", b"SuiOink - The piggy  powered meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000518_2e54e6b0ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

