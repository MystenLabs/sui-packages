module 0x65aea6fcdfa57847334cfe32785d45ca749d20548b0cc4ee2cdcf1cfdde0fe2a::med {
    struct MED has drop {
        dummy_field: bool,
    }

    fun init(arg0: MED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MED>(arg0, 6, b"Med", b"Medicine", b"Reviving the trenches, one med at a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1789557280984.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

