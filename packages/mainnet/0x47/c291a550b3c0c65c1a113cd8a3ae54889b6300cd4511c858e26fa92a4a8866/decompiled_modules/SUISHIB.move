module 0x47c291a550b3c0c65c1a113cd8a3ae54889b6300cd4511c858e26fa92a4a8866::SUISHIB {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 9, b"SUISHIB", x"537569536869626120f09f8c8a", x"537569536869626120f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1652612936764997633/fHY1LNIz_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHIB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

