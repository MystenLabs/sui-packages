module 0x5dd76d122cfe276e76b6df173b8b00fc433fa9655443a8f5de4bcaf239e6ed1e::snt {
    struct SNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNT>(arg0, 6, b"SNT", b"Suinee Todd", b"\"Suinee Todd: The Demon Butcher of Blockchain\" is a dark comedy that combines crypto chaos with the macabre tale of the notorious barber. In this hilarious spoof, Suinee Todd is a rogue developer who uses cutting-edge blockchain technology for sinister purposes, manipulating the market and shaving off fortunes. Instead of a barber's chair, his victims find themselves trapped in a web of failed smart contracts and lost tokens. With sharp wit and satirical commentary on the crypto world, Suinee Todd explores the darker side of decentralized finance, all with a razor-sharp sense of humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9129_14dac266ca.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

