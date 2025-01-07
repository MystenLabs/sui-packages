module 0xe63493707daea1f01e2a13e7bfbe13a33eadafccc7deea4e3f019c3912b4553d::ucat {
    struct UCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCAT>(arg0, 6, b"UCAT", b"Uncle Cat", b"The most handsome cat is now on Sui Network. With a moustache!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/unclecat_118c4dce7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

