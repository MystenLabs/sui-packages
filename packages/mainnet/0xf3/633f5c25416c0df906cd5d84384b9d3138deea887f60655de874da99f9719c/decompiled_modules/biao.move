module 0xf3633f5c25416c0df906cd5d84384b9d3138deea887f60655de874da99f9719c::biao {
    struct BIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIAO>(arg0, 6, b"BIAO", b"BIAO QING", b"Hi, I'm $BIAO QING, the most famous meme in the East, and I'm here to take over the SUI blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Pn_Gc4z_J_400x400_20606c42b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

