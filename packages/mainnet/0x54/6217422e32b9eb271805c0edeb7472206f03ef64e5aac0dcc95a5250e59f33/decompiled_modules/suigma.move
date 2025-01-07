module 0x546217422e32b9eb271805c0edeb7472206f03ef64e5aac0dcc95a5250e59f33::suigma {
    struct SUIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGMA>(arg0, 6, b"SUIGMA", b"SUI SIGMA", b"The most BASED token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp3_74a2cadf7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

