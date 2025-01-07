module 0x15aca88bceb63437fc4ef8cfcc2f7d6c2bcdabc1c75fbeda6f4a1dca4e9d5558::goofy {
    struct GOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFY>(arg0, 6, b"GOOFY", b"Captain GOOFY", b"The greatest fisherman of the @suinetwork ocean rdy to $GOOFY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xe0644f3e46b2d9f319a2cc3491155c75d1b6132ba9b3601c6e7e102e17296645_goof_goof_9f2fd686d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

