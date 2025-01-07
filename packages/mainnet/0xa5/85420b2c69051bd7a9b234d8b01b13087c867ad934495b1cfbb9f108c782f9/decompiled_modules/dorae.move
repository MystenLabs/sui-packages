module 0xa585420b2c69051bd7a9b234d8b01b13087c867ad934495b1cfbb9f108c782f9::dorae {
    struct DORAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORAE>(arg0, 6, b"Dorae", b"Doraemon", x"42696e616e6365277320616e6e6f756e63656d656e742070726f7669646564206f7572207465616d207769746820736f6d6520696e737069726174696f6e2e0a0a447572696e67206f7572206c61737420737465616c7468206c61756e63682c20776520686164206e6f20636f6d6d756e69747920666f756e646174696f6e20616e642077657265207065726365697665642062792065766572796f6e65206173206120636f6e737069726163792067726f75702e0a0a546869732074696d652c2077652077696c6c20666f637573206f6e206275696c64696e672074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726672022901_d0adf9bfc33d19aa54e1b3b1b3536546_14ea11f9c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

