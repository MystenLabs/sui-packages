module 0x70400f2bb2516e944dfe971344659c0bbd96ac52b369e96df55f5d1a71026e25::gurmi {
    struct GURMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURMI>(arg0, 6, b"Gurmi", b"Gurmi on SUI", x"4755524d4920495320412047494741425241494e204d554c544944494d454e53494f4e414c20474f4420574f524d204f4e205355492e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Main_Gurmi_Move_1_b57730504c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

