module 0x1ec938cefa7761f2f85fbbfe9694089f4e1e03206f73146ec191318b65245f10::witches {
    struct WITCHES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCHES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCHES>(arg0, 9, b"WITCHES", x"f09fa799f09f8fbbe2808de29980efb88f57495443484553", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WITCHES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCHES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCHES>>(v1);
    }

    // decompiled from Move bytecode v6
}

