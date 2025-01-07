module 0x1e37137319c756492c5929bbdffbdb57ece9cba08e39e3f226664cfb55130ea9::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47>(arg0, 6, b"TRUMP47", b"Super President Trump 47", b"TRUMP HAS TURNED SUPER!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Dsel8_ZUYI_Xb_Y6yvq_Cjb_NA_1024x1024_158e4102e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

