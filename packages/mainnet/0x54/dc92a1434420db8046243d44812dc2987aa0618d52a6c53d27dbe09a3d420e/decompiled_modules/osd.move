module 0x54dc92a1434420db8046243d44812dc2987aa0618d52a6c53d27dbe09a3d420e::osd {
    struct OSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSD>(arg0, 6, b"OSD", b"ORCA SUI DIAMOND", b"we are the orca sui diamond hand born in $SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22e28225_6760_4183_b8b5_19c8b4149eb1_367b2374be.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

