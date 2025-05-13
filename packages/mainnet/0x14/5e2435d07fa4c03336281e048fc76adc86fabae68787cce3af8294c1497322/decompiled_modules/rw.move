module 0x145e2435d07fa4c03336281e048fc76adc86fabae68787cce3af8294c1497322::rw {
    struct RW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RW>(arg0, 6, b"RW", b"Raweeb", b"anu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicpqfw2pr4s6znjucadrgkackmur2ovpyejxrisdmkazer7mm6v3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

