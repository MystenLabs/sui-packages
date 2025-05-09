module 0xad285826eeadade12b7f6b114488bc624ee8ae6738abf3e84ce163b1d9e90a47::b_inu {
    struct B_INU has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_INU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_INU>(arg0, 9, b"bINU", b"bToken INU", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_INU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_INU>>(v1);
    }

    // decompiled from Move bytecode v6
}

