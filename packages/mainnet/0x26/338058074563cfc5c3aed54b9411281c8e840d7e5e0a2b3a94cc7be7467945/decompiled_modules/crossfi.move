module 0x26338058074563cfc5c3aed54b9411281c8e840d7e5e0a2b3a94cc7be7467945::crossfi {
    struct CROSSFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROSSFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROSSFI>(arg0, 6, b"CrossFi", b"XFI", b"CrossFi is the first cross-chain compatible ecosystem that allows interoperability between crypto and fiat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000409525_8eb6b6a509.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROSSFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROSSFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

