module 0x576e3a5681a729054107d3970f56b4b575542e4cf3d8dcb399bb4b68545b4f03::kotsumet {
    struct KOTSUMET has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOTSUMET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOTSUMET>(arg0, 6, b"Kotsumet", b"KOTARO&HANA", b"OTTERS KOTARO & HANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd773eb0f6a1c7104c8c97baba6514e4_ec13fe46b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOTSUMET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOTSUMET>>(v1);
    }

    // decompiled from Move bytecode v6
}

