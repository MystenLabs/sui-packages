module 0xf9b014e73d64acf883f5bd2bc385433d10c5e5543f51c3176b7baf10df3b67e8::gloooosui {
    struct GLOOOOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOOOOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOOOOSUI>(arg0, 6, b"GLOOOOSUI", b"GLOOSUI", b"Be Gloo, be Bloo. Launching soon on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yjeby_D_400x400_0651fdfef3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOOOOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOOOOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

