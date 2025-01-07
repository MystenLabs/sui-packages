module 0xa7446416852aeca41bdef7b4d541ded15f9222e085e5fac2a566d562eff008ee::gape {
    struct GAPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAPE>(arg0, 9, b"GAPE", b"GALA APE", b"GALACTIC APE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3350a90-7683-4b93-92e8-2f7bcd43f232.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

