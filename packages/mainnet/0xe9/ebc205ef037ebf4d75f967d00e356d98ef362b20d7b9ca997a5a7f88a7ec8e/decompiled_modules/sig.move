module 0xe9ebc205ef037ebf4d75f967d00e356d98ef362b20d7b9ca997a5a7f88a7ec8e::sig {
    struct SIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIG>(arg0, 6, b"SIG", b"SIG on SUI", b"Who is dis bald scrotum? dis is SIG, he is a follicularly challenged bro who enjoys him some hairstyles. the SIG is a trademark, an identity. he rocks hairstyles as he's gonna rock the SUI ecosystem with da power of memetics. SIG can be whoever he wants: the bald, the testosterone hairy, but SIG always chooses being a winner. Inspired by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suispiciously_d1e90c2f1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

