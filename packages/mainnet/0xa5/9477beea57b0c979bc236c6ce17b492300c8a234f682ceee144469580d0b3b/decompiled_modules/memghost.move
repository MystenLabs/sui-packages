module 0xa59477beea57b0c979bc236c6ce17b492300c8a234f682ceee144469580d0b3b::memghost {
    struct MEMGHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMGHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMGHOST>(arg0, 9, b"MEMGHOST", b"Ghost", b"Nfndnnfnfnf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d496ceb-dff5-43f4-be15-eea9e4aef653.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMGHOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMGHOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

