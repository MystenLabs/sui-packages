module 0xb65c2f379c5cbac8e3d93d0e814014c95e9045f8bac61c18642d6824415b1ec7::pettit {
    struct PETTIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETTIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETTIT>(arg0, 9, b"Pettit", b"First Streamer in Space", b"Don Pettit is making history as the FIRST-EVER Twitch streamer in space! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeCDNUo3nitAxPXyPUFhheDPiMobyCxT9AonLf3SjoCp2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PETTIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETTIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETTIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

