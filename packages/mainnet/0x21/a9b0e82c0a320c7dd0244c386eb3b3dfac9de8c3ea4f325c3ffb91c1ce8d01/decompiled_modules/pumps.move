module 0x21a9b0e82c0a320c7dd0244c386eb3b3dfac9de8c3ea4f325c3ffb91c1ce8d01::pumps {
    struct PUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPS>(arg0, 6, b"PUMPS", b"PUMPMARKETS", x"50756d70204d61726b6574730a54686520756c74696d61746520706f696e74732070726f746f636f6c2c206275696c74206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0167_00acebf724.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

