module 0x82524d3b5247e0b8a27a889453e1dd23978c8421acd34ac184d90307b17ce5e1::berry {
    struct BERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERRY>(arg0, 6, b"BERRY", b"PooBerry", x"5468652074797065206f66206265727279207468617420616c6c20616e696d616c206f776e6572732068616420746f207365652c20616e64206465616c20776974682061746c65617374206f6e636520696e207468656972206c6966652c20736f6d65206861746520697420736f6d65206c6f7665206974210a42757420616674657220616c6c20776520616c6c206e65656420736f6d6520506f6f426572727920696e206f7572206c697665732e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_1_cb31a48a0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

