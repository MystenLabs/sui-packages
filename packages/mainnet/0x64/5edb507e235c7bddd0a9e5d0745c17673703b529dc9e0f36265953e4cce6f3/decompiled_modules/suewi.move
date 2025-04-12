module 0x645edb507e235c7bddd0a9e5d0745c17673703b529dc9e0f36265953e4cce6f3::suewi {
    struct SUEWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEWI>(arg0, 9, b"SUEWI", b"SUI DOG", b"Lengest Hottus Doggus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/51b4d2c7a1d5e9e242fbfe196f0700c2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUEWI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEWI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

