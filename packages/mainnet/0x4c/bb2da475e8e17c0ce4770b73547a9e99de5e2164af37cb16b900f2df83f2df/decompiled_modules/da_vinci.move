module 0x4cbb2da475e8e17c0ce4770b73547a9e99de5e2164af37cb16b900f2df83f2df::da_vinci {
    struct DA_VINCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DA_VINCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DA_VINCI>(arg0, 9, b"DA VINCI", x"f09f96bcefb88f44612056696e6369", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DA_VINCI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DA_VINCI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DA_VINCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

