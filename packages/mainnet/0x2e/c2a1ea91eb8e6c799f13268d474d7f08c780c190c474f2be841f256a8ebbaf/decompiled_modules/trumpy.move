module 0x2ec2a1ea91eb8e6c799f13268d474d7f08c780c190c474f2be841f256a8ebbaf::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"TRUMPY", b"Trumpy", b"TRUMPY - More than just a meme coin, we are a fusion of martial arts mastery and blockchain innovation. Through humor, relatability, and a powerful community, we aim to be the ultimate marketing force for SUI, driving growth with every move. Enter the dojo. Kick first, ask questions later", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250501_014340_662_d2cabdd360.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

