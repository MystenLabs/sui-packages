module 0x700e12b1407e1d926f71f5864d5843993d6843c5f5046ef6c8c7786cb64cf48f::suiboyz {
    struct SUIBOYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOYZ>(arg0, 6, b"SUIBOYZ", b"Sui Boyz Club", b"Caught them meeting somewhere in the SUI blockchain, but dont know their names", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_BOYZ_4f19465404.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOYZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

