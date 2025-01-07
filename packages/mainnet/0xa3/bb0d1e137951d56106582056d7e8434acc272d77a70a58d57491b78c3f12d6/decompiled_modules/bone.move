module 0xa3bb0d1e137951d56106582056d7e8434acc272d77a70a58d57491b78c3f12d6::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Bone On SUI", b"Dog By Matt Furie ($BONE) brings the playful spirit of Matt Furies art to the digital world. Celebrating Furies latest creationa charming dog sketched on paperthe $BONE token connects fans with the whimsical universe of \"Boys Club\" characters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_8e1b0a9599.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

