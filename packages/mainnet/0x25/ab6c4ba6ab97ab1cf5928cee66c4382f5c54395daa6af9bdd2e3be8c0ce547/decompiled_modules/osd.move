module 0x25ab6c4ba6ab97ab1cf5928cee66c4382f5c54395daa6af9bdd2e3be8c0ce547::osd {
    struct OSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSD>(arg0, 6, b"OSD", b"ORCA SUI DIAMOND", b"we are the orca sui diamond hand born in $SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22e28225_6760_4183_b8b5_19c8b4149eb1_19ad576aca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

