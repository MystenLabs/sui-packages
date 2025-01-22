module 0xf4df482ab36d0254251f13e603bc1aceb9c2a4130f93669e126773d8158a79e6::arc {
    struct ARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARC>(arg0, 9, b"arc", b"AI Rig Complex", b"we're here to make you take the red pill. then, the blue pill.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPDJuEobBcLZihjFCvkWA8c1FiW7UzM2ctFdiffSLxf1d")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

