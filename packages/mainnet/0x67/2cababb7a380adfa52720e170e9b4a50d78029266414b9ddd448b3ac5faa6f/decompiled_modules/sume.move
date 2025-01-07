module 0x672cababb7a380adfa52720e170e9b4a50d78029266414b9ddd448b3ac5faa6f::sume {
    struct SUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUME>(arg0, 6, b"SUME", b"SUI of Meme", b"The followers of various memes believe in the Holy Bible of Water and regard it as their doctrine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bz_Q_Tl_Zx_B_400x400_fe5ca5af5b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

