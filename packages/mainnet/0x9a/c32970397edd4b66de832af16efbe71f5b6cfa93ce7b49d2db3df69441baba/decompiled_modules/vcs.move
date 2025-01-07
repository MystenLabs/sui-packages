module 0x9ac32970397edd4b66de832af16efbe71f5b6cfa93ce7b49d2db3df69441baba::vcs {
    struct VCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCS>(arg0, 9, b"VCS", b"FDSF", b"VBCBG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b2b91a10-fe78-40e2-84dc-46a1aff0f24b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

