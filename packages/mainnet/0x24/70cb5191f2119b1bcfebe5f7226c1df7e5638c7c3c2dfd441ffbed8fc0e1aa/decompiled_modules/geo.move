module 0x2470cb5191f2119b1bcfebe5f7226c1df7e5638c7c3c2dfd441ffbed8fc0e1aa::geo {
    struct GEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEO>(arg0, 9, b"GEO", b"GeoTang", b"Geo  is a reliable and innovative cryptocurrency that combines advanced security measures with smart contract capabilities, enabling seamless automation of agreements. Built on a decentralized blockchain platform, it ensures transparency and resistance to censorship while maintaining high transaction speeds. With a focus on sustainability and community engagement, SmartToken is positioned as a versatile asset for users and developers alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/40cda0f5d5c1a5e2e24527ccbbfe3b8cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

