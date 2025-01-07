module 0x16a68773468f990f452b3d5de95b9fdb83cff1b77460f7063a9731de5245d8e0::babyotter {
    struct BABYOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYOTTER>(arg0, 6, b"BABYOTTER", b"Baby Otter On Sui", b"Don't miss Baby Otter with 0% taxes! Our project is designed specifically for the community. Join us and grow together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/78abe4b1d5ddc88ddcbbf77e9d2fef12_4b64cfd5b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

