module 0x23c9828a3303dc052247acc1f1037ec9ecbac8be758b00bd7f5ea0b471aa158f::pofo {
    struct POFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POFO>(arg0, 6, b"POFO", b"Ponk Fork", b"PORK and PONKE are two most successful ETH and SOLANA trends and now together they became POFO - the new SUI trend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/plague_e4550d00ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

