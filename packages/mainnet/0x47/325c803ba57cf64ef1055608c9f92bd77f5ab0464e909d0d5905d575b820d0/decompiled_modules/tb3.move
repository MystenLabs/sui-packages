module 0x47325c803ba57cf64ef1055608c9f92bd77f5ab0464e909d0d5905d575b820d0::tb3 {
    struct TB3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB3>(arg0, 6, b"TB3", b"Thunderbird3", b"Thunderbird three of four | Get 'm all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TB_2_39c2470bca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TB3>>(v1);
    }

    // decompiled from Move bytecode v6
}

