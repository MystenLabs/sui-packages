module 0x78b09a71af467446f8beefb150999711fcd9d1c937da03a8dc5999b87de24f8a::blusui {
    struct BLUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUSUI>(arg0, 6, b"BLUSUI", b"BLUSUI COIN", b"BLUSUI  is inspired from the Sea Beast with couple twists. Rewords stakers and brings a fresh start on SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreief6qytzjmkxuhgns3uftocwoot2xqyu5whgim56oodmbntyu5gom")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

