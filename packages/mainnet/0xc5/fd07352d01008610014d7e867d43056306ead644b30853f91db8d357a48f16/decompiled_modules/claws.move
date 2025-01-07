module 0xc5fd07352d01008610014d7e867d43056306ead644b30853f91db8d357a48f16::claws {
    struct CLAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWS>(arg0, 6, b"CLAWS", b"Captain Claws", b"Remember that life is claw-some.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lobster_aaab31a89e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

