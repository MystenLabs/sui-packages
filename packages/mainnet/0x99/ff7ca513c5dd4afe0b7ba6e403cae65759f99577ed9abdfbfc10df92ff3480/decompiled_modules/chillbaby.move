module 0x99ff7ca513c5dd4afe0b7ba6e403cae65759f99577ed9abdfbfc10df92ff3480::chillbaby {
    struct CHILLBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBABY>(arg0, 6, b"CHILLBABY", b"LOWKEY CHILL BABY", b"Start small, grow big! Just like a newborn, $CHILLBABY is all about early beginnings. Invest while it's young, nurture it, and watch it grow into something extraordinary. The earlier you start, the bigger the rewards. Dont miss your chance to secure your futureride the $CHILLBABY wave to success!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_V_Dn_IRG_4_400x400_a50f323044.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

