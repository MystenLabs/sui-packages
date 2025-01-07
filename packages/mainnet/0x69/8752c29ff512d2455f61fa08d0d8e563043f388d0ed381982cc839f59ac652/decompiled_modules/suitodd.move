module 0x698752c29ff512d2455f61fa08d0d8e563043f388d0ed381982cc839f59ac652::suitodd {
    struct SUITODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITODD>(arg0, 6, b"SuiTodd", b"Suinee Todd", b"\"Suinee Todd: The Demon Butcher of Blockchain\" is a dark comedy that combines crypto chaos with the macabre tale of the notorious barber. In this hilarious spoof, Suinee Todd is a rogue developer who uses cutting-edge blockchain technology for sinister purposes, manipulating the market and shaving off fortunes. Instead of a barber's chair, his victims find themselves trapped in a web of failed smart contracts and lost tokens. With sharp wit and satirical commentary on the crypto world, Suinee Todd explores the darker side of decentralized finance, all with a razor-sharp sense of humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9129_f66dcb4157.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

