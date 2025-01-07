module 0x697d327f0f120e0624210b45fff68614004dcc41aac305465c789f5cd53b62f6::ping {
    struct PING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PING>(arg0, 6, b"PING", b"PING ON SIU", x"50696e6720697320612070656e6775696e672074686174206c6f76657320746f2062652074726561746564206c696b652061206b696e672e204272696e672068696d20666f6f6420746f2068697320626564206f722068656c6c2065617420796f7520616c6976652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ping_e4fd49f053.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PING>>(v1);
    }

    // decompiled from Move bytecode v6
}

