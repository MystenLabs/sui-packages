module 0x85d27c10640b7efc0672649c640b72ca35187f38189dee569f514b537abba816::ptang {
    struct PTANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTANG>(arg0, 6, b"PTANG", b"Poo Tang Cat", b"Known on the streets as Pooa rogue vigilante by day, a savage ladies man by night. On sui, hes bringing justice where others cant while stacking as much $PTANG as possible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033521_b8b7389b05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

