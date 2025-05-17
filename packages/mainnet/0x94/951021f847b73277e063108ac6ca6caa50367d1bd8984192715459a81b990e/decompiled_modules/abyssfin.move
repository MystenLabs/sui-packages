module 0x94951021f847b73277e063108ac6ca6caa50367d1bd8984192715459a81b990e::abyssfin {
    struct ABYSSFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABYSSFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABYSSFIN>(arg0, 6, b"ABYSSFIN", b"Sui Abyssfin", x"416279737346696e20697320616e20696e6e6f76617469766520746f6b656e206f6e2074686520737569206e6574776f726b2c20696e737069726564206279207468650a6d7973746572696f757320637265617475726573206f66207468652064656570206f6365616e2e20416279737346696e20696e63656e746976697a65730a636f6d6d756e6974792070617274696369706174696f6e207768696c65206e617669676174696e672074686520776174657273206f662074686520626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigyixxa6ksoqmchbg7fhiy2m223wwhzsdar6uejvbqhqcv4x5pfxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABYSSFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABYSSFIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

