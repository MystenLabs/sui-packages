module 0x7fcf6e73ed402f89c4e02857ba931c7319dc095a224dc409990799c1434e4b4c::kumbara {
    struct KUMBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMBARA>(arg0, 6, b"KUMBARA", b"KumbaraTR", x"53657276656e696d2068657267756e203120535549276c696b204b554d4241524120616c6d616b2e2042752073657276656e656e652073697a6c65726964652062656b6c69796f72757a2e2e2e200a42697220656b736967697a2053656e6465204b4154494c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000630_84d9748f20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

