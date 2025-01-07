module 0x39cb2a2f9bb59f40e4a88b37d593cb9d201477583d7a1acb93fb997619662792::dgsag {
    struct DGSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSAG>(arg0, 9, b"DGSAG", b"DAG", b"SAF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b944bc7a-9ab4-4746-85ec-9996b682302e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

