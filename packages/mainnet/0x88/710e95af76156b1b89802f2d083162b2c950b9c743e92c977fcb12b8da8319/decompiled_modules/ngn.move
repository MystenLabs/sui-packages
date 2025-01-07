module 0x88710e95af76156b1b89802f2d083162b2c950b9c743e92c977fcb12b8da8319::ngn {
    struct NGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGN>(arg0, 6, b"NGN", b"THE LEGEND OF THE NINGEN", b"A legend that lives deep in the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031459_39018480f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

