module 0xd56113d4d2f40be4143d51787dd8f1d20a8a01d29b86b4ad2f2de3731b8ba5d0::weedz {
    struct WEEDZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEEDZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEEDZ>(arg0, 9, b"WEEDZ", b"WEEDZARD", b"420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f7e3333bdf2fd202ca88e696f82d38f0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEEDZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEEDZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

