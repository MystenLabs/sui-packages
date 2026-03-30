module 0xaa63b5f0f142a179511d47b35185ce4422bbdcd04809380fa25855c77bf739d2::hijack {
    struct HIJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIJACK>(arg0, 6, b"HIJACK", b"Hijack", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIJACK>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIJACK>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HIJACK>>(v2);
    }

    // decompiled from Move bytecode v6
}

