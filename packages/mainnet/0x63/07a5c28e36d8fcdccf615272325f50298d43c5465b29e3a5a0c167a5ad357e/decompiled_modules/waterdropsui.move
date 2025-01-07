module 0x6307a5c28e36d8fcdccf615272325f50298d43c5465b29e3a5a0c167a5ad357e::waterdropsui {
    struct WATERDROPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERDROPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERDROPSUI>(arg0, 6, b"WaterdropSui", b"WATERDROP", b"We come from the Trisolaran world, our next goal: SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1713641351864_b9e7fcedaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERDROPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERDROPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

