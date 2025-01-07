module 0x9b9b352dfce0624657b4b92deba50e5c04b8d26adaa7681428d77dc2c094335e::suihei {
    struct SUIHEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHEI>(arg0, 6, b"SUIHEI", b"SUIHEI OHTANI", b"$SUIHEI OHTANI the legendary player on SUIDODGERS will make his first homerun here on  SUI ecosystem!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled348_20241024233040_1_6552ce9278.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

