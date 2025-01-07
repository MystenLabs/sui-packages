module 0x653d4c5bfe9184a20727631ec2fe673c94592efce045cae5766d1e91036c62e6::suiren {
    struct SUIREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREN>(arg0, 6, b"SUIREN", b"SIREN OF SUI", b"The vigilant siren of the Sui seas, skilled in detecting scammers lurking in the depths. With it's enchanting yet fierce presence, $SUIREN protects the Sui waters, calling out fraudsters and keeping the Sui network safe. Ride the waves of security with $SUIREN as your guide!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIREN_f534239f28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

