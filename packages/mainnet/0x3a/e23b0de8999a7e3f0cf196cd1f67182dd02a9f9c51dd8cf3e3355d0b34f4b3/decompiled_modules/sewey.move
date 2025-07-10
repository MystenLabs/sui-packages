module 0x3ae23b0de8999a7e3f0cf196cd1f67182dd02a9f9c51dd8cf3e3355d0b34f4b3::sewey {
    struct SEWEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEWEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEWEY>(arg0, 6, b"Sewey", b"Sewey fast blockchain", b"fast and good blockchain, excellent technology incredibly fast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigcwywycwt4ezfzvmpcavetqg5y76nexreexozc3dzsg3yfsea7ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEWEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEWEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

