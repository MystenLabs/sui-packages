module 0x23669e6886d5904beaaa64cbeb452e835726347836386710a868d96f20f456dc::b_zer0 {
    struct B_ZER0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZER0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZER0>(arg0, 9, b"bZER0", b"bToken ZER0", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZER0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZER0>>(v1);
    }

    // decompiled from Move bytecode v6
}

