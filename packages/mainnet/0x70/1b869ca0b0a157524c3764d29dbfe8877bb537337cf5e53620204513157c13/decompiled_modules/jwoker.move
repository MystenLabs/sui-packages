module 0x701b869ca0b0a157524c3764d29dbfe8877bb537337cf5e53620204513157c13::jwoker {
    struct JWOKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JWOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JWOKER>(arg0, 6, b"JWOKER", b"Jwokercoin", b"$Jwoker - The clown who somehow mastered the art of shitcoin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058375_ec7a8f6576.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JWOKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JWOKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

