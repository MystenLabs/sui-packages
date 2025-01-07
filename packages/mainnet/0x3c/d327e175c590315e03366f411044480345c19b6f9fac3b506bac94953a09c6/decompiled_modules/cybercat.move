module 0x3cd327e175c590315e03366f411044480345c19b6f9fac3b506bac94953a09c6::cybercat {
    struct CYBERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERCAT>(arg0, 6, b"CyberCat", b"Cyber Cat", b"Curiosity Fuels the Market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008834_52013a8a6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

