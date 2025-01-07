module 0xc4bed42193c9b4bbd155f6507a578bb792ab673d87657fbe3cbf3ba9ff08c31f::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKEY>(arg0, 6, b"DUCKEY", b"Duckey By MattFurie On Sui", b"Meet Duckey, the face of our new meme token, $DUCKEY is Inspired by Matt Furie Artwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_e_6d544a3dc6.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

