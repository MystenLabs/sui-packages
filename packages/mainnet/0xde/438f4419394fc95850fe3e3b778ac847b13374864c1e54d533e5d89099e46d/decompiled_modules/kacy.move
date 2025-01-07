module 0xde438f4419394fc95850fe3e3b778ac847b13374864c1e54d533e5d89099e46d::kacy {
    struct KACY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KACY>(arg0, 6, b"KACY", b"Kacy On Sui", b"Kacy - The epitome of loyalty, strength, and charm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013434_be97c3827a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KACY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KACY>>(v1);
    }

    // decompiled from Move bytecode v6
}

