module 0xe02049388ef56bee49c0dc586dd6ff8048c0767be278e01b7ec7e21c813093d7::sprise {
    struct SPRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRISE>(arg0, 6, b"SPRISE", b"SUIprise", b"Enjoy the SUIprise!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGOSUIPRISE_d3adc7d5ba.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

