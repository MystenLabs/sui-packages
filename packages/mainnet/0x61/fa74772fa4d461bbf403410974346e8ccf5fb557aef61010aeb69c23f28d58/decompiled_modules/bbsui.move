module 0x61fa74772fa4d461bbf403410974346e8ccf5fb557aef61010aeb69c23f28d58::bbsui {
    struct BBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUI>(arg0, 6, b"BBSUI", b"Baby Water", b"cute water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/321_fb7f976355.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

