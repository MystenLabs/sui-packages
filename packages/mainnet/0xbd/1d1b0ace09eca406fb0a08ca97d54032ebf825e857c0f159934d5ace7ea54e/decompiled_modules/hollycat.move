module 0xbd1d1b0ace09eca406fb0a08ca97d54032ebf825e857c0f159934d5ace7ea54e::hollycat {
    struct HOLLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLLYCAT>(arg0, 6, b"HOLLYCAT", b"Holly Cat", b"Holly Cat is a meme token built around the iconic and playful character of a cat named Holly. Designed to capture the spirit of internet culture and decentralized innovation, Holly Cat focuses on community engagement, creativity, and lighthearted participation in the world of digital assets. It offers a unique identity in the meme coin space, aiming to create a vibrant ecosystem where community involvement and fun go hand in hand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreichwp65skoxvuo5qg7eqpcbcn5xrf3gebi2xwsd6r4efrhwbbsfri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOLLYCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

