module 0x49d5397be6589f67414e5507288aa11ba413132255b95b27d0db947ff4891434::blayt {
    struct BLAYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAYT>(arg0, 6, b"BLAYT", b"Suika Blyat", b"Get ready to blayt your way through the world of crypto with Suika Blaytwhere fun meets finance on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIG_1_1_3e325d2275.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAYT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

