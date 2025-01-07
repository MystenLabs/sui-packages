module 0x3b781df5d8948bfd9c7fd96cc42f96e096dfdb66d5871a8eb9f226f7362b077f::akiracat {
    struct AKIRACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIRACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKIRACAT>(arg0, 6, b"AKIRACAT", b"Akira Cat On Sui", b"A cat with an extraordinary dream; to swim in water on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_232054_8484ef2dae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIRACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKIRACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

