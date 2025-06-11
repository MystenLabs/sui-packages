module 0xd6b5aef91acdfb89f52057c2716a7ac4a18e1f9353d7563953f15dac562e6edc::undead {
    struct UNDEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDEAD>(arg0, 9, b"GU", b"undead", b"undead are now dead. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/74502bb9-30d6-4687-8542-3582684e6e49.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNDEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDEAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

