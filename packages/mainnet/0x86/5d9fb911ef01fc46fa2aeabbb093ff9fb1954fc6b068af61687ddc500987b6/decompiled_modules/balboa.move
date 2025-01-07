module 0x865d9fb911ef01fc46fa2aeabbb093ff9fb1954fc6b068af61687ddc500987b6::balboa {
    struct BALBOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALBOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALBOA>(arg0, 6, b"BALBOA", b"SUIVESTER STALLONE", b"It's not about how hard you hit, it's about how much you can take and keep moving forward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1460b_rocky_c663da4b02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALBOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALBOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

