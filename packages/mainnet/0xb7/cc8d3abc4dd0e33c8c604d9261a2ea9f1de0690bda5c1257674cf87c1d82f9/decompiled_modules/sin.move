module 0xb7cc8d3abc4dd0e33c8c604d9261a2ea9f1de0690bda5c1257674cf87c1d82f9::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIN>(arg0, 6, b"SIN", b"SINVERSE", b"Sinverse is a mysterious and immersive platform where sins are judged, measured, and forever inscribed on the blockchain. Powered by the Infernal Intelligence, it evaluates confessions, assigning a weight to each sin, revealing its true depth. $SIN is the essence of this forbidden system, driving judgment, purification.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1a99ce8895.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

