module 0xff1782c04f39965137c51d9149624f8ee5ef7edc169863777889f705c613af1e::mellow {
    struct MELLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELLOW>(arg0, 6, b"MELLOW", b"Mello The Marshmallow", x"4120736f667420616e64207768696d736963616c20637265617475726520737072656164696e67206d617273686d616c6c6f77206d616769632066617220616e6420776964652e200a0a53776565742c20636f7a792c20616e642066756c6c206f6620636861726d202d206a6f696e2074686520666c7566666965737420616476656e747572652120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_165703_580_a86bd82fd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

