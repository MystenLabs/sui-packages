module 0x51eb0bab917154fcdc8fa583b975cb5012a040c5d3703d89b57fdc626c48ae32::orca {
    struct ORCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCA>(arg0, 6, b"ORCA", b"ORCA THE PREDATOR", b"The orca (Orcinus orca), or killer whale, is a toothed whale and the largest member of the oceanic dolphin family. It is the only extant species in the genus Orcinus and is recognizable by its black-and-white patterned body. A cosmopolitan species, it is found in diverse marine environments, from Arctic to Antarctic regions to tropical seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Orca_2_1bb4739d08.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

