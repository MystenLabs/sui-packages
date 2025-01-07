module 0x183530621d84d1c5125a0543298a9db00d92bf02ed18d9bca61774634aacefbc::elfie {
    struct ELFIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELFIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELFIE>(arg0, 9, b"ELFIE", b"Eva Elfie", b"Eva Elfie is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i1.sndcdn.com/avatars-5ORkLXa9XxPQWcO6-uqNm2Q-t1080x1080.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELFIE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELFIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELFIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

