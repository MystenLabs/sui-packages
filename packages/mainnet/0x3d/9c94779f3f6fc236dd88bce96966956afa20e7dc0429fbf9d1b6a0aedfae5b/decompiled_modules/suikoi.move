module 0x3d9c94779f3f6fc236dd88bce96966956afa20e7dc0429fbf9d1b6a0aedfae5b::suikoi {
    struct SUIKOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKOI>(arg0, 6, b"SUIKOI", b"Koi On Sui", b"$SUIKOI is the most unique and lucky fish in the Sui Ocean, staying true to its roots and bringing wealth and dynamic energy to the Sui Network. With the lore of the legendary red koi fish, $KOI symbolizes prosperity and joy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001889_a555b777be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

