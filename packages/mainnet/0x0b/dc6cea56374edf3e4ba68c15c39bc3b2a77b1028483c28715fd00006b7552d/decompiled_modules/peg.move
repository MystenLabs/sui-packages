module 0xbdc6cea56374edf3e4ba68c15c39bc3b2a77b1028483c28715fd00006b7552d::peg {
    struct PEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEG>(arg0, 6, b"PEG", b"Jpeg", b"Its just jpegs lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000092783_38031178dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

