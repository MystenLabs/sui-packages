module 0xa3e6468a7b53da623bb1a89eaaa0ae0d56a4356e6ede25fecb13a57eb92e8abc::b_tlp {
    struct B_TLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TLP>(arg0, 9, b"bTLP", b"bToken TLP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

