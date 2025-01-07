module 0xa4626bff53006e7297eb8eec332642d9d0c9be82a522aace1c01c6d77f103dd7::crb {
    struct CRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRB>(arg0, 9, b"CRB", b"Crab", b"crab is a crab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4638f23-2ce6-43a8-96cb-1028e650e601.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

