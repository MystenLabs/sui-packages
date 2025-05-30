module 0x730c3a6ac860e8c5eac8f7d845d2e57991558d038daf4a9f27adef0d1a32e23f::wobbuffet {
    struct WOBBUFFET has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOBBUFFET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOBBUFFET>(arg0, 6, b"WOBBUFFET", b"POKEWOB", b"Join the wobble. Reflect the chaos. Counter to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2rjpy57gtw6fogz4ue6z4qq2zf36pg5d5d4wf3lepfbhodmixru")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOBBUFFET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOBBUFFET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

