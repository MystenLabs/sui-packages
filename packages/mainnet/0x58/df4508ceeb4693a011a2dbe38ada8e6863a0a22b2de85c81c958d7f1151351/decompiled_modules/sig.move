module 0x58df4508ceeb4693a011a2dbe38ada8e6863a0a22b2de85c81c958d7f1151351::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"Sig on Sui", b"Who is dis bald scrotum? dis is SIG, he is a follicularly challenged bro who enjoys him some hairstyles. the SIG is a trademark, an identity. he rocks hairstyles as he's gonna rock the SUI ecosystem with da power of memetics. SIG can be whoever he wants: the bald, the testosterone hairy, but SIG always chooses being a winner. Inspired by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suispiciously_52cd4652f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

