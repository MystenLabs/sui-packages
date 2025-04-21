module 0x2a3bb045fface0097a8a5c5e20dc261d26b8ae81333f9bb4e44cd99bb8203d6f::HAWK {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 6, b"HAWK", b"hawk tuah", b"hawk tu ah... hawk tu ah...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qme32mSUKfMnJJ1dg6nvXVbjw93iw8CxmUchU8VXDUbDjY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAWK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

