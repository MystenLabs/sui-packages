module 0xcd9661d76f8dc72c406fc89b53dc3d30b15c72d1300481b998e854467b7b5822::trnch {
    struct TRNCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRNCH>(arg0, 6, b"TRNCH", b"SUI TRENCH", b"Welcome to Sui Trench (TRNCH), a community-driven and secure meme token on the Sui Blockchain. Sui Trench is built to offer a fun yet reliable investment opportunity, combining the excitement of meme tokens with a focus on long-term growth and safety.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_TRENCH_887a919af0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRNCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRNCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

