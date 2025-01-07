module 0xa18bb109be0293cb4208df570c6e7163a5bda8799179a20695aa9ae654454aa9::shitsui {
    struct SHITSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITSUI>(arg0, 6, b"SHITSUI", b"ShitSui", b"SHIT SUI, the cutest little Shih Tzu on the SUI Network, trots through the ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_150102_ace6d76c60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

