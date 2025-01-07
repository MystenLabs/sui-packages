module 0x3e2b7b6e8498a7e169a588edde288d3438e0c0dd0edd1164c652fa48b394db31::plip {
    struct PLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLIP>(arg0, 6, b"PLIP", b"PLIPSUI", b"This space is used to briefly communicate your brands main selling points.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_461fb3ee6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

