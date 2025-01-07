module 0xd0ee60d9bb34a70ce53d6d8b3646af0a010fe4d27c423059a30548727e46ff7c::dob {
    struct DOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOB>(arg0, 6, b"DOB", b"dogbite", b"\"If you don't buy, the dog will bite you\" Join the fiercest meme token on the blockchain! dogbite is here to take a bite out of the market. Don't miss out on this wild ridebuy now before its too late.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sticker_from_Telegram_1_fdee6951f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

