module 0xcedc47622cb5a705744d3e3709d8bea61351b61bcf58ecb20d28afc7a1634222::duko {
    struct DUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKO>(arg0, 6, b"DUKO", b"Duko", b"Grab this cute little $DUKO, that's your today's bullish!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mama_8cf2db8edd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

