module 0x645beaa7794bd809a160683d39b55fc5cd8fd42528226ee320c4a3a0a9f43773::mdrop {
    struct MDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDROP>(arg0, 6, b"MDROP", b"M Drop", b"Fuck it. $MDROP launched. Site & TG on the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifbo36yxcx3vr4yv2glxj5ppc7nx3ut666yxnnnd37lgh73dd7uoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MDROP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

