module 0x8c99ef7ff52d79f8d0d4a41babf452c0b923de31548c973ad7cc758d8aae4b46::suibunny {
    struct SUIBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUNNY>(arg0, 6, b"SUIBUNNY", b"SUI BUNNY", b"$SUIBUNNY is the latest sensation in the memecoin universe, bringing laughter and lighthearted fun to the crypto space. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny2_97d57ac635.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

