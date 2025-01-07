module 0x4f2912e38de78c7082417eb64bf798a8f0550eb7684712d0629ff296e294febe::dmplus {
    struct DMPLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMPLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMPLUS>(arg0, 9, b"DMPLUS", b"Digital ma", b"Token of Digital master ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8eb4732-ad6d-4545-b9cc-967cf1f17a90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMPLUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMPLUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

