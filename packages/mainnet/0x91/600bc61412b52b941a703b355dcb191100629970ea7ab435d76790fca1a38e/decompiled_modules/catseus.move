module 0x91600bc61412b52b941a703b355dcb191100629970ea7ab435d76790fca1a38e::catseus {
    struct CATSEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSEUS>(arg0, 6, b"CATSEUS", b"CATSEUS MAXIMUS", b"Catseus Maximus is a revolutionary meme token inspired by the power of cats as Roman deities. With a golden laurel helmet and imperial spirit, Catseus Maximus combines strength, charm, and community. Join the epic journey to conquer the blockchain with the eternal majesty of feline greatness!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007368_43c255f9f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

