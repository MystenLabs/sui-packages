module 0xe55772cc658d0c19e4dd1f7d9a7dc325220ef8241876c62319a685f3cdd86342::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"Suiperman", b"suiperman", b"No description ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000158868_2f60d15a01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

