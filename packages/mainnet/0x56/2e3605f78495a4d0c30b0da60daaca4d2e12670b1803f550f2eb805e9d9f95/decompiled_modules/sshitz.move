module 0x562e3605f78495a4d0c30b0da60daaca4d2e12670b1803f550f2eb805e9d9f95::sshitz {
    struct SSHITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHITZ>(arg0, 6, b"sShitz", b"sShit sShit", b"sShit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dawdwa_e3743c6db9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHITZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHITZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

