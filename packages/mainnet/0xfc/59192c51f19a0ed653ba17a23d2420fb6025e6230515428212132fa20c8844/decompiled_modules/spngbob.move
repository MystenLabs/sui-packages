module 0xfc59192c51f19a0ed653ba17a23d2420fb6025e6230515428212132fa20c8844::spngbob {
    struct SPNGBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPNGBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPNGBOB>(arg0, 6, b"SPNGBOB", b"SPONGEBOB", b"SPONGEBOB is the head of the underwater kingdom of BIKINISUI...................................lol.............", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPONGE_554593337d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPNGBOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPNGBOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

