module 0x1b6fe2f64a2ed3028d5c7013779430151447e697e11efd509bb083a96b891655::THEE {
    struct THEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEE>(arg0, 6, b"THEE", x"54696d6f7468c3a965204368616c616d6574", b"timouxi cha la mei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmfSACsJmbDFrZ725eme7w9LhvKoMezmbQGi16sGGTZhxA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

