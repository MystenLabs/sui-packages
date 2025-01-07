module 0x671892cc1d3a088bad6bb1578a63219505ffc81ceb05ed2e040b7d34f143471b::toon {
    struct TOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOON>(arg0, 6, b"TOON", b"TOONSUI", x"474d2c207765207365652065766572797468696e67207765207472792065766572797468696e672e0a746865206c617374207468696e672077652077616e6e6120646f20697320746f2074657374206974206f75742c206275636b6c652075700a666f722024544f4f4e202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039962_bbc67888f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

