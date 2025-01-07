module 0xb0db4762ee6f770df11942587963162026f9fd5acdc061088895b812df0e1dad::aaab {
    struct AAAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAB>(arg0, 6, b"AAAB", b"aaaBird", b"Can't stop thinking about SUI, Won't stop thinking about SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bckh9bt44zg31_229c756d03.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

