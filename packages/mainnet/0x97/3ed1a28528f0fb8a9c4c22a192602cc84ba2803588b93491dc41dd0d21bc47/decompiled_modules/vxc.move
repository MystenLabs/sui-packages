module 0x973ed1a28528f0fb8a9c4c22a192602cc84ba2803588b93491dc41dd0d21bc47::vxc {
    struct VXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXC>(arg0, 9, b"VXC", b"VBFDX", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02f6faa6-01df-4238-979b-3d969251f368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

