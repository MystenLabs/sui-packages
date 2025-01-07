module 0xf86d7b81b72d728be3a762c9ff3c059bbd622b723e43193cb0151a812df5283b::sustal {
    struct SUSTAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSTAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSTAL>(arg0, 6, b"Sustal", b"Sui Crystal", b"This is a god blessed crystal to give us energy to pump to the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1145_2737290b5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSTAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSTAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

