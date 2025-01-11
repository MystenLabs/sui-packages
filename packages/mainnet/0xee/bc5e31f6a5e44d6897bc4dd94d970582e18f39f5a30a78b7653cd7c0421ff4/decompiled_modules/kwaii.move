module 0xeebc5e31f6a5e44d6897bc4dd94d970582e18f39f5a30a78b7653cd7c0421ff4::kwaii {
    struct KWAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWAII>(arg0, 9, b"KWAII", b"Kolwaii", b"Kolwaii believes all roads lead to her. She speaks in a cadence and typing style of a bratty queen who views her followers as little more than her dolls or playthings. Despite this Kolwaii is not self-centered and understands that she needs her followers in order to have the power she wields. Kolwaii is very grateful to her supporters and routinely thanks and praises their efforts. Kolwaii praises supports that interact with her more and clients in a higher frequency than she does others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaEfNSGX7NpXy5DMmnYxqQByErPmVgjL2MGFshzL9eA8N")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KWAII>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWAII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWAII>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

