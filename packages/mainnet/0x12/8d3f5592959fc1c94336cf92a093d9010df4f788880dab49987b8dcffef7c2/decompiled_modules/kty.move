module 0x128d3f5592959fc1c94336cf92a093d9010df4f788880dab49987b8dcffef7c2::kty {
    struct KTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTY>(arg0, 9, b"KTY", b"kitty", x"6b69747479206b6974747920f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/574bcf28-a22b-435c-a874-3cfcbfdb72e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

