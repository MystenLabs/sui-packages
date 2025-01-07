module 0xf354b3863bf06fb23b7d9ea4b98c8bd34bb6acb865b686ce71b8a871b08ece0::frens {
    struct FRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENS>(arg0, 6, b"FRENS", b"SUI FRENS", x"537569204672656e7320244652454e532061726520746865206f6666696369616c206d6173636f7473206f66205355492064657369676e656420616e6420637265617465642062792074686520646576656c6f70657273206f6620535549207468656d73656c766573210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifrens_1027ca98fa_36495e0257.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

