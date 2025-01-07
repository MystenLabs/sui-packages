module 0xd231564dea0720372728ce0040c316838dd726043b0cdb6410ae29079108666c::yuna {
    struct YUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUNA>(arg0, 6, b"YUNA", b"Yuna On SUI", b"Yuna, once a close friend of $Kabosu and now an ally of Neiro, is the first Black and Tan $Shiba Inu from this generation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_M_Si_T5_2_400x400_748f3f17c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

