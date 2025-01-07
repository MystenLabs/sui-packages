module 0x705479efcab8c3db6ff1456221d1cc03f63f3d0beef9dd3e1b5a06278bb1b204::cpt {
    struct CPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPT>(arg0, 9, b"CPT", b"ChiefPries", b"Renewed Hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb9456a3-6d5e-4a13-af0e-a6a0bc993f31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

