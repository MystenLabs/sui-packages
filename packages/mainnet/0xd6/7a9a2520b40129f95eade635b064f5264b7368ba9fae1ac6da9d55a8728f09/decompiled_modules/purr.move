module 0xd67a9a2520b40129f95eade635b064f5264b7368ba9fae1ac6da9d55a8728f09::purr {
    struct PURR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURR>(arg0, 6, b"Purr", b"Sui Cat", b"Born to purr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiev4gr56ywskrtegvxcmullqbpc5b2aqv7nhgxcwwwe4xcdk3ilr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PURR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

