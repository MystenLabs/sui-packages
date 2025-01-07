module 0x65bef99d5bd49638c5109731862be937748692c6efa9eb985f2c92bec6e2e480::fofar {
    struct FOFAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOFAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOFAR>(arg0, 6, b"FOFAR", b"FoFar Sui Gaming Platform", b"Dexscreener paid.Check now:https://www.fofarsui.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_30_99ea45a70d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOFAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOFAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

