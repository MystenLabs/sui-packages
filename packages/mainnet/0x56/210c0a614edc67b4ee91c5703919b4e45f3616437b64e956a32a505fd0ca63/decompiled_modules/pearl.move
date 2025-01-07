module 0x56210c0a614edc67b4ee91c5703919b4e45f3616437b64e956a32a505fd0ca63::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"Pearl", b"1Pearl", b"The world's most expensive pearl was discovered on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEARL>(&mut v2, 1, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v2, @0x5710c5729b50804fc4304c9095089b74dbd22ab0c891720fd3a86fa416791d26);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

