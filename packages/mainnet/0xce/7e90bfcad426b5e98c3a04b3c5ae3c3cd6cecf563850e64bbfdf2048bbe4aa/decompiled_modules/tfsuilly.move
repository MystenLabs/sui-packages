module 0xce7e90bfcad426b5e98c3a04b3c5ae3c3cd6cecf563850e64bbfdf2048bbe4aa::tfsuilly {
    struct TFSUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFSUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFSUILLY>(arg0, 6, b"TFSUILLY", b"The Free Suilly", b"The Free Suilly is a rebellious and free-spirited force in the Sui blockchain, representing the untamed essence of decentralization. Suilly roams the digital landscape without rules or boundaries, breaking free from traditional systems and embracing the chaotic freedom of the crypto world. With a playful yet defiant attitude, The Free Suilly inspires a community of like-minded adventurers who seek liberation from the norm and chase after the unpredictable thrills of the decentralized future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/perfs_30cb80c400.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFSUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TFSUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

