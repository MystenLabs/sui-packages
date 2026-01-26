module 0xdb2f53fadfbd57ac138b12ff140bc1e73912c574153c0fc69a53d51b5ca71e7::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOFI>, arg1: 0x2::coin::Coin<LOFI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LOFI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOFI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOFI>>(0x2::coin::mint<LOFI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<LOFI>(arg0, 9, b"LOFI", b"LOFI", x"4c4f464920e28094206368696c6c2076696265732c20676f6f64206d757369632c207a65726f20737472657373206d656d6520636f696e206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.tusky.io/5ab323c3-19e1-48b1-a5e2-f01b2fb3a097")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<LOFI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LOFI>>(v0);
    }

    // decompiled from Move bytecode v6
}

