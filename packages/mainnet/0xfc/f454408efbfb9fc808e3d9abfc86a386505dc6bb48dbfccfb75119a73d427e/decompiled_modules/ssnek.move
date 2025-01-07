module 0xfcf454408efbfb9fc808e3d9abfc86a386505dc6bb48dbfccfb75119a73d427e::ssnek {
    struct SSNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSNEK>(arg0, 6, b"SSNEK", b"SUI SNEK", b"Meet $SSNEK will increase you bean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3635_2ee37f2e7a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSNEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSNEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

