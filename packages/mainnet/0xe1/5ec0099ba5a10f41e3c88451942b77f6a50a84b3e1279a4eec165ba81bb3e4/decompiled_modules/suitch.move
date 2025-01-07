module 0xe15ec0099ba5a10f41e3c88451942b77f6a50a84b3e1279a4eec165ba81bb3e4::suitch {
    struct SUITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCH>(arg0, 6, b"SUITCH", b"Suitch", b"$SUITCH is a token inspired by the character Stitch, adapted for the SUI network. As a meme token, it combines the rebellious and charismatic nature of the famous alien with the cutting-edge technology of the SUI blockchain, creating a fun and irreverent blend for the crypto community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_5a751cf93c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

