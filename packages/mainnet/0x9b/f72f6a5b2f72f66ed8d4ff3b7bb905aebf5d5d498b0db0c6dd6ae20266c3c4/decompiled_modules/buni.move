module 0x9bf72f6a5b2f72f66ed8d4ff3b7bb905aebf5d5d498b0db0c6dd6ae20266c3c4::buni {
    struct BUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNI>(arg0, 6, b"BUNI", b"Buni The Rabbit", x"48692c2069276d2042756e6920746865206d6f737420706f70756c617220726162626974206f6e205265646469742e2049276d20776869746520616e6420686176652061206269672062616c6c732e0a0a68747470733a2f2f7777772e7265646469742e636f6d2f757365722f62736b79686f707065722f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2_077b706990.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

