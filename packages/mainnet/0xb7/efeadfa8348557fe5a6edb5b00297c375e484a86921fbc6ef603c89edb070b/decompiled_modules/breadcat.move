module 0xb7efeadfa8348557fe5a6edb5b00297c375e484a86921fbc6ef603c89edb070b::breadcat {
    struct BREADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADCAT>(arg0, 6, b"BREADCAT", b"Bread Cat", b"Meow loaf? Catwich? Bread Cat! Lets grab a slice of this purrfect bread!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/breadcatprofil_40d8be0339.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

