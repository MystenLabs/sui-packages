module 0x90930e0de6e9ab648a1f93aea7cc91fa29079b3597005947c84d880ec0da1c2d::smui {
    struct SMUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMUI>(arg0, 6, b"SMUI", b"SMUI on Sui", b"Smui is the weirdest character on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smuipfp_eafce41de8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

