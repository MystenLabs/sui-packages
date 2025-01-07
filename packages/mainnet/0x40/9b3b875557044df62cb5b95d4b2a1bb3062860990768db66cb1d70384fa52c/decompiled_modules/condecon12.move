module 0x409b3b875557044df62cb5b95d4b2a1bb3062860990768db66cb1d70384fa52c::condecon12 {
    struct CONDECON12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDECON12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONDECON12>(arg0, 9, b"CONDECON12", b"condecon", b"de leo nui la ba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8926b8d-0691-4914-8e63-9727626223be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDECON12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONDECON12>>(v1);
    }

    // decompiled from Move bytecode v6
}

