module 0x722067a29042a74bcbe280cddbbff089d7195969d147a129f0425ce1d96d021d::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 6, b"MNT", b"Mantle", b"Mantle | Mass adoption of decentralized & token-governed technologies. With Mantle Network, Mantle Treasury, and token holder-governed product initiatives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_884256f7a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

