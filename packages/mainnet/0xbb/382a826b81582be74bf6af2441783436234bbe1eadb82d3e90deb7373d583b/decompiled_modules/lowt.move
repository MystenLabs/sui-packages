module 0xbb382a826b81582be74bf6af2441783436234bbe1eadb82d3e90deb7373d583b::lowt {
    struct LOWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOWT>(arg0, 9, b"LOWT", b"LowTest", b"low-sui migration test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOWT>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOWT>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

