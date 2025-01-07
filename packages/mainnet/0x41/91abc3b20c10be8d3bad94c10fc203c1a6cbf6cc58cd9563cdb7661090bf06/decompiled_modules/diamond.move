module 0x4191abc3b20c10be8d3bad94c10fc203c1a6cbf6cc58cd9563cdb7661090bf06::diamond {
    struct DIAMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMOND>(arg0, 6, b"DIAMOND", b"Diamond Hands Guy On Sui", b"Hold for dear life $DIAMOND on SUI | SUI : $50", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_49_d9c0b7330c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMOND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMOND>>(v1);
    }

    // decompiled from Move bytecode v6
}

