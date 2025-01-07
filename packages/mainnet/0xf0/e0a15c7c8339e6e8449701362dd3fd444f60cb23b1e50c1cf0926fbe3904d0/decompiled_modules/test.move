module 0xf0e0a15c7c8339e6e8449701362dd3fd444f60cb23b1e50c1cf0926fbe3904d0::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<TEST>(arg0, 6, b"TEST", b"TODO: Fill this in (name of the coin)", b"TODO: Fill this in (description of the coin)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"TODO: Fill this in (icon of the coin)")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

