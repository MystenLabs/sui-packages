module 0xabac44fcc3b9b0e613f6124feb272bc86865b5d00ce9bab0692a29da394c452d::nk {
    struct NK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NK>(arg0, 9, b"NK", b"NEAL", b"DIGITAL AI PLATFORM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/7f1b6ef0-dc0b-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NK>>(v1);
        0x2::coin::mint_and_transfer<NK>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

