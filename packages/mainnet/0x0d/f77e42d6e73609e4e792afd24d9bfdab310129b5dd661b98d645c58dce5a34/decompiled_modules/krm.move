module 0xdf77e42d6e73609e4e792afd24d9bfdab310129b5dd661b98d645c58dce5a34::krm {
    struct KRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRM>(arg0, 9, b"KRM", b"KARMA", b"Each owner of the $KARMA token cleanses his karma from negativity, and the owners of special NFTs accumulate positive karma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec2df93b-d631-40cc-9b37-e5c9c3a358dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

