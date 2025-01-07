module 0x70f3adec06a7c230279bcdb96a00ebc0ff04e5b22d4276f00905d06288e28f4c::didler {
    struct DIDLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDLER>(arg0, 6, b"DIDLER", b"DID DIDLER", b"Enter description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c0f2f6f4d1e128b09b904c5153d6e5ae_3cdc2ba06d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

