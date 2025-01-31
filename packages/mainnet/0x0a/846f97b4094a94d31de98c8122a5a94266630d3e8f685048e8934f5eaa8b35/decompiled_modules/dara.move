module 0xa846f97b4094a94d31de98c8122a5a94266630d3e8f685048e8934f5eaa8b35::dara {
    struct DARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARA>(arg0, 6, b"DARA", b"Dancing Rat and more", b"Dance and chat with our rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rat_dance_db4c518073.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

