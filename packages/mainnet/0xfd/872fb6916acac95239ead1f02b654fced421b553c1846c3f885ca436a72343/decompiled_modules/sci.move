module 0xfd872fb6916acac95239ead1f02b654fced421b553c1846c3f885ca436a72343::sci {
    struct SCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCI>(arg0, 6, b"SCI", b"Seal Cat Inu", x"5365616c202b20436174202b20496e75203d204d4f4f4e206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003621_57f0506eae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

