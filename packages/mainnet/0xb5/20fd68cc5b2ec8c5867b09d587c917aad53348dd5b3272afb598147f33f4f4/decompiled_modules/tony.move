module 0xb520fd68cc5b2ec8c5867b09d587c917aad53348dd5b3272afb598147f33f4f4::tony {
    struct TONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONY>(arg0, 6, b"TONY", b"TONY THE DUCK", b"Tony swoops into the blockchain pond, making tidal waves and ruffling feathers in the Ton network. Tonys Quack attack is simple, he sets out to influence other ducks to join the flock and embark on a journey that will forever change the landscape of TON. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tony_95b03beb32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

