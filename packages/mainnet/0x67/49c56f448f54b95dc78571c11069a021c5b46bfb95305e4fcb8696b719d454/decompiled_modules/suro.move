module 0x6749c56f448f54b95dc78571c11069a021c5b46bfb95305e4fcb8696b719d454::suro {
    struct SURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURO>(arg0, 6, b"SURO", b"SUROSUI", x"746865206869707065737420746967657220796f75276c6c2065766572206d6565742e20466f72676574206c75726b696e6720696e2077657420666f72657374202074686973206269672063617420676f742061206d6561646f7720616e64206120736572696f75732063617365206f6620746865206368696c6c732028696e2074686520626573742077617920706f737369626c652c206f627673292e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BASEPORO_1_4417400954.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

