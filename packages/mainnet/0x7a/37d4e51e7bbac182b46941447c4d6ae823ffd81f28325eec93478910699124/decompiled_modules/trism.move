module 0x7a37d4e51e7bbac182b46941447c4d6ae823ffd81f28325eec93478910699124::trism {
    struct TRISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRISM>(arg0, 6, b"Trism", b"Trumptism", b"Trumptism is a name for the special type of autism our president has.this form of autism is what makes it possible for trump to behave how he does without understanding whats wrong with his behavior. Trumptism is whats wrong with America!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fffdf_3e091d5005.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

