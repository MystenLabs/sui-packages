module 0x85eebbabb6a9976c4ca09d33e0988f1efe5e13ca74c77e3bbc267870988511ee::syan {
    struct SYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYAN>(arg0, 6, b"SYAN", b"Super Saiyan Cat", b"No tuna? Time to unleash the ultimate power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_231812_ac475cdd69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

