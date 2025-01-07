module 0x298a66475d14795c3b514210bc2c7ce00060de04b0ef42492f0af96605fca1ee::bone {
    struct BONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONE>(arg0, 6, b"BONE", b"Sui Flea Bone", b"Will be launching in minutes hyped gamble play, SUI version of Matt Furies Fleabone, content is really hot, dyor if going in ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_sc29ry_6d0882483e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

