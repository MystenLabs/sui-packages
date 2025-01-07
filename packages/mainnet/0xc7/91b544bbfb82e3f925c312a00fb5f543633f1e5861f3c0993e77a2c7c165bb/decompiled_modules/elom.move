module 0xc791b544bbfb82e3f925c312a00fb5f543633f1e5861f3c0993e77a2c7c165bb::elom {
    struct ELOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELOM>(arg0, 6, b"Elom", b"Elom Mars", b"Elom Mars is a meme coin which is dedicated to Elon Musk's mars mission. They've been looking for a water on mars, but sui waterchain is already there. Elom tend to be the very first mars cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ykahd3_2e2db75592.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

