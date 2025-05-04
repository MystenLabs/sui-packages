module 0xef24902bce1da286a1d348c053e5a4fc88b5b45829269941794ddca80bbb93f6::kfrc {
    struct KFRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KFRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFRC>(arg0, 6, b"KFRC", b"Kfroc", b"Smart and adorable frog is KFRC, He is quiet does not mean he does not fight he can make waves with his natural strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vw9tuk_5465d04a5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KFRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KFRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

