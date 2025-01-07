module 0xcc5d98639016ec31caf7cd7d20bb5557f6c4acff1c40e16c1d7bc51d864a3f53::ditto {
    struct DITTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITTO>(arg0, 6, b"Ditto", b"Ditto on Sui", b"Welcome Ditto, your favorite slime friend on the sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/sdfggfd_f642fc5a0d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DITTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

