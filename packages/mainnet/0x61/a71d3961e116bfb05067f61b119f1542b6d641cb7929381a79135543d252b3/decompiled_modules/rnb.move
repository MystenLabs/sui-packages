module 0x61a71d3961e116bfb05067f61b119f1542b6d641cb7929381a79135543d252b3::rnb {
    struct RNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RNB>(arg0, 9, b"RNB", b"rainbow", x"20627269676874656e696e6720796f757220696e766573746d656e74732077697468206d756c74692d68756564206761696e73f09f8c88", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5d72081-ca2a-46df-98e0-57c6e1970348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

