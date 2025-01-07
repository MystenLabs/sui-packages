module 0x539eec25908aab86b43a4a874d6c827f27edd2538f50a5d575b2da0b3ee1cc2f::scb {
    struct SCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB>(arg0, 6, b"SCB", b"Supplex City Bitch", b"Welcome to \"Supplex City Bitch\"!  Its like a wrestling ring for crypto, where traders body slam their way through wild market swings. Get ready to throw down with some epic gains or end up tapping outthis is where the real action happens!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdererrew_10253d0eb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

