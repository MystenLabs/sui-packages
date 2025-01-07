module 0xd0e7609b6caabd75d57f4b1bf6f096304ab3d1d4e5b7a2d14a088bad55d55689::nrng {
    struct NRNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRNG>(arg0, 6, b"NRNG", b"No Risk No Gain", b"Take the risk and you will make your gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731164879045.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NRNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

