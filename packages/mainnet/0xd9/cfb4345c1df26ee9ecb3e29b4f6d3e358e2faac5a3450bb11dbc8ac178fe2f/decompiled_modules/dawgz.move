module 0xd9cfb4345c1df26ee9ecb3e29b4f6d3e358e2faac5a3450bb11dbc8ac178fe2f::dawgz {
    struct DAWGZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWGZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWGZ>(arg0, 6, b"Dawgz", b"SuiWeed Dawgz", x"225355497765656420446177677a2069732074686520756c74696d61746520667573696f6e206f66206368696c6c20766962657320616e642063727970746f20696e6e6f766174696f6e2e204578706c6f7265206f75722068756220666f7220757064617465732c2066656174757265732c20616e642074686520667574757265206f662074686520446177677a206d6f76656d656e742e2220200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017605_79eb1a5ef2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWGZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAWGZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

