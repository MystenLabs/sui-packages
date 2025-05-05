module 0x73e84d9218d0d4e38e7b1523b53f2a2d82de350f9671dd9bc219bbda64f7de94::shouse {
    struct SHOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOUSE>(arg0, 6, b"SHOUSE", b"1 SUI = 1 HOUSE", b"WHEN 1 SUI BECOMES EQUAL TO 1 HOUSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie4kmuajfbr7ibajxw5i6hwg44jdrjaqorxio4d3qcmgpguyolho4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOUSE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

