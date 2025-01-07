module 0xb7ca056c221127da7c719b35377946b732c4829067b295650883787a1407959c::xiaomi {
    struct XIAOMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIAOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIAOMI>(arg0, 6, b"XIAOMI", b"Xiaomi Cat", b"Xiaomicat  | $Xiaomi $Xiaomi from tech to cat, now on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_6d1ad5b3fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIAOMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIAOMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

