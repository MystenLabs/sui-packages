module 0xb55b671a6c1a60e7ec74a6e618e671b1f1e58e95bc1eded8df58c37ceb45259e::wfrog {
    struct WFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WFROG>(arg0, 6, b"WFROG", b"waterfrog", b"This was no ordinary frog; its a tadpole with the unmistakable, mischievous face of Pepe, the internet' s favorite meme frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0055_504a7578d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

