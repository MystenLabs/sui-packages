module 0xae76a0d01317a6a95d00ec0b7e2feefeba9e0fde81cd36e0959e7f94e4daa8e8::suips {
    struct SUIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPS>(arg0, 6, b"SUIPS", b"SUIPTOS", b"suiptos is a memecoin that is to dedicated to sui and aptos tecnology", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_b185f8dc67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

