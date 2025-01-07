module 0x7696c4cf0dfd19752d39665d23b297ea9fa0bc4c1f29b5896eac098245dea53f::suiken {
    struct SUIKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEN>(arg0, 6, b"SUIKEN", b"SUIKEN TOKEN", b"Suiken is a meme token on the Sui, combining the fun of shuriken vibes with the power of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIKEN_39778501ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

