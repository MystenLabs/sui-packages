module 0x4c8ec5ee7e37a431811b2a7e8b84b8a0ff2f4c42c92c9c3a41281eed00495e0d::capo {
    struct CAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO>(arg0, 6, b"CAPO", b"CAPOV2", b"CapoV2 The Future Has Arrived", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgigwbnoxupdmpw7o353yjuocble4oeixvcjtxzljtaa52g7ogly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

