module 0xa317d87ac0feedb8dde3a57b6ac36dffc27d1ed99d26a884f9f86b35f791e452::kat {
    struct KAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAT>(arg0, 6, b"KAT", b"SUI KATTS", b"Rumor has it Owning a Sui Katt grants you unlimited meme wisdom and access to the most legendary alpha leaks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001335408_8a09cd1aeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

