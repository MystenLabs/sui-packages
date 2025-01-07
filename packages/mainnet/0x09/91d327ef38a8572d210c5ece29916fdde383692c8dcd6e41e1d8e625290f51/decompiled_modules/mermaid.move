module 0x991d327ef38a8572d210c5ece29916fdde383692c8dcd6e41e1d8e625290f51::mermaid {
    struct MERMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAID>(arg0, 9, b"MERMAID", b"Mermaid Coin", b"Mermaid Is Meme real On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845517158052462592/JY2_wm5Z.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MERMAID>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERMAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

