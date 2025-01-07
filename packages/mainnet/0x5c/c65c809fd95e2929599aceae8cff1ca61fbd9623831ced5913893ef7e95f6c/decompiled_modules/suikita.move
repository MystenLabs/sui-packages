module 0x5cc65c809fd95e2929599aceae8cff1ca61fbd9623831ced5913893ef7e95f6c::suikita {
    struct SUIKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKITA>(arg0, 6, b"SUIKITA", b"Suikita", b"Blue, pink, and determined  #Suikita is the new token set to shake up #SUI! Join the pack and lets build the future together ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sukita92_17710c07dd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

