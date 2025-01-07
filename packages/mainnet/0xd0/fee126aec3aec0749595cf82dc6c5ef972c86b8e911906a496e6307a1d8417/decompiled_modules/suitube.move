module 0xd0fee126aec3aec0749595cf82dc6c5ef972c86b8e911906a496e6307a1d8417::suitube {
    struct SUITUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITUBE>(arg0, 6, b"SuiTube", b"Sui Tube", b"The First Decentralized Video and Media Platform on $Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951245459.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITUBE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUBE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

