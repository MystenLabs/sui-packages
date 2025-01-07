module 0x498d8b9d9d29c2a321786644b02c13af34f7878793312546a472b37a8585eedd::CLOCK {
    struct CLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOCK>(arg0, 6, b"CLOCK", b"CLOCK", b"123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUg6UU34jaXJ2ZRx8ivFs2H3mHypoMjbXmoT745oHV7Ua")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

