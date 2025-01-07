module 0xd067cd72e2a7d9c21ed1dd94762de98f594ab4c7ab556d30b94bb55d0e3758e7::peneb {
    struct PENEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENEB>(arg0, 9, b"PENEB", b"kelw", b"bw w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aafc664b-177e-48b1-8171-fe5b899e024f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

