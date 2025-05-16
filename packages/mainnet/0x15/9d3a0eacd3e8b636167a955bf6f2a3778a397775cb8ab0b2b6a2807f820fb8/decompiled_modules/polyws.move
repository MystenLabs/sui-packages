module 0x159d3a0eacd3e8b636167a955bf6f2a3778a397775cb8ab0b2b6a2807f820fb8::polyws {
    struct POLYWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLYWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLYWS>(arg0, 6, b"POLYWS", b"Poliwhirl Sui", x"24504f4c595753206973206e6f74206f6e6c792061206d656d6520636f696e2062757420616c736f20612066756e20616374696f6e206f6e20537569204e6574776f726b2e0a204c6574277320616e6e6f74617465207468697320627562626c65206869676820616e6420746f726e61646f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigx6r6anoeixclsi7htdqp7r6lnlwqqyoqa2knvyfxwgwuechjbxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLYWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLYWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

