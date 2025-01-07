module 0xc59693b5e25e3fc5bb198eaf464f175f6371c8c417cd3a8aae6047d4d4cd60cb::dca {
    struct DCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCA>(arg0, 6, b"DCA", b"Degens Chasing Anything", b"Dca on you bag! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051829_08a04a80a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

