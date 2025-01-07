module 0x69ee04f5885eb2b2db94e3223403b50b98b2b204ad92615a2195376e5e5113b5::chub {
    struct CHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUB>(arg0, 6, b"Chub", b"Chubfish", b"Fat fish on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3228_26f6fec78d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

