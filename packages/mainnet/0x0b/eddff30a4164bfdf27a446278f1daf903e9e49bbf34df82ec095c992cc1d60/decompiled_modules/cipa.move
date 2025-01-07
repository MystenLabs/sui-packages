module 0xbeddff30a4164bfdf27a446278f1daf903e9e49bbf34df82ec095c992cc1d60::cipa {
    struct CIPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIPA>(arg0, 6, b"CIPA", b"Chipacabra", b"Chipacabra eats the bull's pussy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chupacabra_257b0bcce5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

