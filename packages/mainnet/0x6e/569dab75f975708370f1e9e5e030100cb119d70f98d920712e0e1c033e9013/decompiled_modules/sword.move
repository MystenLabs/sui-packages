module 0x6e569dab75f975708370f1e9e5e030100cb119d70f98d920712e0e1c033e9013::sword {
    struct SWORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORD>(arg0, 6, b"SWORD", b"SWORD SUI", b"The legendary memecoin forged in the fires of SUI. Wield the power of the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib3joe7cdhu7vcjynasczo7rwqtxuhm2qvl6tcpmogp3gfmaod55a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

