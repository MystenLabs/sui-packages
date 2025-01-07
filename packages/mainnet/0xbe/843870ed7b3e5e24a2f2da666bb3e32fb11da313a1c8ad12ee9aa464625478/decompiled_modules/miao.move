module 0xbe843870ed7b3e5e24a2f2da666bb3e32fb11da313a1c8ad12ee9aa464625478::miao {
    struct MIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAO>(arg0, 6, b"MIAO", b"Sui Cat Miao", b"Miao is a cute cat memecoin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015358_aa062f93a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

