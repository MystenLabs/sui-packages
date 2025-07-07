module 0x6fb3031c8ae2f415b547d86f81f7675be9173b8cd44a803617d8b167973a938a::bonk {
    struct BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONK>(arg0, 6, b"BONK", b"Blue Bonk", b"Blue Bonk, the Sui version of Bonk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiafx77zhf66ae6zzsnhbkwv6culjrnu7hpvcotvvltjnjzmvk6n6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

