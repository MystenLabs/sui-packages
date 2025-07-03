module 0x270318985c84a31422bd0584bb59f4b509d6732f632c5af7903a33328155ee5b::st {
    struct ST has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ST>, arg1: 0x2::coin::Coin<ST>) {
        0x2::coin::burn<ST>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<ST>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(arg0, @0x0);
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 6, b"ST", b"SecureToken", x"f09f9a802053656375726520746f6b656e20776974682072656e6f756e636564206f776e657273686970202d2068747470733a2f2f746573742e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/RUT6rYl.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

