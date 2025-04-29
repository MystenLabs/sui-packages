module 0x9ee20f24dd0e935196b2df5f5c4240d63c20e208fa357438f103fee06cb6357c::b_dks {
    struct B_DKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DKS>(arg0, 9, b"bDKS", b"bToken DKS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

