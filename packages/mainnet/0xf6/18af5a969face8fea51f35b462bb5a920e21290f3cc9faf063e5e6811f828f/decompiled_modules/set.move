module 0xf618af5a969face8fea51f35b462bb5a920e21290f3cc9faf063e5e6811f828f::set {
    struct SET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SET>(arg0, 6, b"SET", b"Suieet", b"The Sweetest  Memecoin on #SUI Join the community http://t.me/Suieetcommunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiet_861e94806c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SET>>(v1);
    }

    // decompiled from Move bytecode v6
}

