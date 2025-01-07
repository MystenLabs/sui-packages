module 0x2e2573038eca0d9db58a8f62c08f28d9368b425ed6e31725fbe36af906a4045f::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Bone", b"Dog By Matt Furie ($BONE) brings the playful spirit of Matt Furies art to the digital world. Celebrating Furies latest creationa charming dog sketched on paperthe $BONE token connects fans with the whimsical universe of \"Boys Club\" characters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_35275a3e4b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

