module 0xf7dac51bc43614b5608bcc5fc466c3e421deea792f35e3b0926dc7a1f727a8e5::rip {
    struct RIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIP>(arg0, 6, b"RIP", b"RIP PEANUT", b"TO THE MEMORY OF LOVING PET AND FUCK THE NYSDEC , NO TWITTER OR TELEGRAM , THIS IS A TRIBUTE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peanut_a04d1fcbc7.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

