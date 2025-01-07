module 0xf9678b5f66603de941f6dc6bee416aecc00f7b6217476b2f4b6a485a86b3368c::yourmom {
    struct YOURMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURMOM>(arg0, 6, b"YOURMOM", b"YOURMOM!", b"To all the Solana memecoin degens spamming my mentios, I have one pet and it's name is your mom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4f5r3_ZOU_400x400_a8e944d6f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURMOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOURMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

