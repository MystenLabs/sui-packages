module 0x58fb59b1b8ff6392887eefe7832c4af432a94855de5fb35c7e7a1302711399f9::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"Bone", b"BONE", b"BONE is an open source, with 3% SUI rewards, on the Sui blockchain, favoured by memecoin lovers worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_bone_6e20c30b7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

