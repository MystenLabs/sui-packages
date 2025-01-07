module 0x820740e36d6bcca8d21d27e7bfe30d9ffa43a5654e91d743f725c695c464b18e::seahorse {
    struct SEAHORSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAHORSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAHORSE>(arg0, 6, b"SeaHorse", b"SeaHorse sui", x"536561486f72736520686173206172726976656420746f2074686520537569204e6574776f726b2e0a456d62726163652074686520626561757479206f6620746865206f6365616e20616e642069742773206c6976696e67206372656174757265732e0a546f6765746865722077652063616e2068656c70206d616b652061206368616e67652e0a537461792074756e656420666f72206f757220526f61646d61702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seahorse6_911f3c9380.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAHORSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAHORSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

