module 0xca08d82c0055cc9b50422374665e6fce87ba14efb629db9153e08955786c91ce::magababy {
    struct MAGABABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGABABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGABABY>(arg0, 6, b"MAGABABY", b"MAGA BABY", b"Let's Go MAGA BABY! It's going to be HUUU-GE! You've never seen anything like it before! Bringing awareness to babies in the womb while giving back on the way to Space!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_27_010455_e034d2651d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGABABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGABABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

