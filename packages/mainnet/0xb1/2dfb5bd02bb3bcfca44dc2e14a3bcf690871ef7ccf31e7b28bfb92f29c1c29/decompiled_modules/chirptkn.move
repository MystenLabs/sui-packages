module 0xb12dfb5bd02bb3bcfca44dc2e14a3bcf690871ef7ccf31e7b28bfb92f29c1c29::chirptkn {
    struct CHIRPTKN has drop {
        dummy_field: bool,
    }

    struct ChirpTknAdmin has key {
        id: 0x2::object::UID,
        trs: 0x2::coin::TreasuryCap<CHIRPTKN>,
    }

    fun init(arg0: CHIRPTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIRPTKN>(arg0, 6, b"CHIRP", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIRPTKN>>(v1);
        let v2 = ChirpTknAdmin{
            id  : 0x2::object::new(arg1),
            trs : v0,
        };
        0x2::transfer::transfer<ChirpTknAdmin>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun treasury(arg0: &mut ChirpTknAdmin) : &mut 0x2::coin::TreasuryCap<CHIRPTKN> {
        &mut arg0.trs
    }

    // decompiled from Move bytecode v6
}

