module 0x2e6a5eece51304428dc5064d459bae370fc60838de1687e269196eb5f0d627dc::nur {
    struct NUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUR>(arg0, 9, b"NUR", b"Nurai", b"Nurtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6ca48e1d-6c7a-4f17-81d9-84243304951d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

