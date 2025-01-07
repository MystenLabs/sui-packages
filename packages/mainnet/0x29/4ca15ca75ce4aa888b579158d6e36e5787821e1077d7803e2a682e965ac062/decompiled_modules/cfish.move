module 0x294ca15ca75ce4aa888b579158d6e36e5787821e1077d7803e2a682e965ac062::cfish {
    struct CFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFISH>(arg0, 9, b"CFISH", b"CoolFish", x"53756d65726769c3a96e646f746520656e20656c206d756e646f20646520537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/864094cbc500216beb160fa6b3861a51blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFISH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

