module 0x2d24dd60c41445e061f250a6d7f36def29d433bb5773d9627c863314826d1317::doki {
    struct DOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOKI>(arg0, 6, b"DOKI", b"Doki Dog", b"Doki dog is The golden retrievier that will lead the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022904_06969e35e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

