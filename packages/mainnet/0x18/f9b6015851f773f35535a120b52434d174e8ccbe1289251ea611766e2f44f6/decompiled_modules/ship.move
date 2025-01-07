module 0x18f9b6015851f773f35535a120b52434d174e8ccbe1289251ea611766e2f44f6::ship {
    struct SHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIP>(arg0, 6, b"SHIP", b"STARSHUIP", x"535441525348554950206973206865726520746f206675656c20796f75722063727970746f20647265616d7320776974682074686520706f776572206f66206d656d657320616e64207468652070726f6d697365206f6620696e74657267616c61637469632066756e2e205768657468657220796f75277265206120726f636b657420656e7468757369617374206f72206a757374206c6f766520726964696e6720746865207761766573206f6620687970652c205348495020697320796f7572207469636b657420746f206f726269742e20f09f8ca0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732016617736.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

