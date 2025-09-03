module 0x65b3db01dd36de8706128d842ca3d738ed30bd72c155ea175a44aedca37d4caf::ebasis {
    struct EBASIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBASIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBASIS>(arg0, 6, b"eBASIS", b"Ember Basis", b"This receipt token represents the shares a user has of the MEV Capital Basis Vault on Ember", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/logos/eBASIS.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBASIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBASIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

