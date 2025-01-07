module 0xd0ea55e920d21e9e956992270094fbbad9ff4a1ac6b146914992cb49069c2c69::goob {
    struct GOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOB>(arg0, 6, b"Goob", b"Goob is good", b"Goob vibe only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_83af71125a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

