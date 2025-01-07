module 0x5892766975f30d26143489c20a2a80ffda2cad031ebfadf62299cfe1c42a75c6::suiberry {
    struct SUIBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERRY>(arg0, 6, b"SUIBERRY", b"Sui Berry", x"57686174206465736372697074696f6e20646f20796f75206e656564206f66206120626c7565206265727279207468697320697320676f6c64210a5053313a2044455620686f6c64732061206c6f7420617320492077696c6c2062652070726f6d6f74696e6720776974682074686520746f6b656e73204920686f6c6420616e642074686572652077696c6c206265207365766572616c206d6f7265207365726965732e0a5053323a57616974696e6720746f207570646174652074686520776562736974652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_2_4efb50009c_348bf011ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

