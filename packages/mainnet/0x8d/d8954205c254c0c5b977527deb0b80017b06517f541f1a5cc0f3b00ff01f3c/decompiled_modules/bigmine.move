module 0x8dd8954205c254c0c5b977527deb0b80017b06517f541f1a5cc0f3b00ff01f3c::bigmine {
    struct BIGMINE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIGMINE>, arg1: 0x2::coin::Coin<BIGMINE>) {
        0x2::coin::burn<BIGMINE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIGMINE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BIGMINE>>(0x2::coin::mint<BIGMINE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BIGMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGMINE>(arg0, 9, b"BIGM", b"BigMine", x"546f6b656e207061726120656c206a7565676f206465206d696e6572c3ad61204269674d696e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/CxgzjgxB/Dise-o-sin-t-tulo-73.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGMINE>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BIGMINE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BIGMINE>>(0x2::coin::mint<BIGMINE>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

