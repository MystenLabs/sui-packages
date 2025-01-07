module 0x84cd6c19bcb1284b7925c1b1e085156aafedf29658ac335a1a052bc3c0f4a57c::bonesui {
    struct BONESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONESUI>(arg0, 6, b"BoneSUI", b"Bone ShibaSwap ON SUI", b"Official Bone ShibaSwap ON SUI  of the Shiba Inu Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bone_shibaswap_bone_logo_2011c91c59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

