module 0x5fb5dc70507b4b66a78003ddbf33214d4b0ed2842beffd69b50ccd0aa50a8081::gsg {
    struct GSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSG>(arg0, 9, b"GSG", b"GokuSaiyanGenesis", b"GokuSaiyanGenesis was born when a cosmic event merged the DNA of a legendary Saiyan warrior with the spirit of a rebellious meme. This fusion resulted in a token that grants its holders the ability to transform into a Super Saiyan at will, boosting their strength and agility to unprecedented levels. The token's power is said to be so immense that it can alter the fabric of space-time, creating a new universe every time it's activated. GokuSaiyanGenesis is not just a meme; it's a sci-fi legend in the making.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739202421/mwxda21ixmkozckfvbgo.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

