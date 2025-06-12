module 0xe0e2aa414c7d1bfbeddac734449987316b6f1ba9e9727746cee1daec9921871b::meiko {
    struct MEIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIKO>(arg0, 6, b"MEIKO", b"Meiko Shiraki", b"Meiko Shiraki is a meme token project on the Sui blockchain, inspired by the confident and bold character from the anime world. Known for her striking presence and sadistic charm, Meiko embodies a unique blend of charisma and rebellion.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieuog4dbdsm5q3izbqxoyb6ci3swya6o2sz5hdwu25tsgubdx34oq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

