module 0x2ba575fdaa1c77ffa77e65786b3efea8035220c330528faaa315c6f8101f6083::duckoff {
    struct DUCKOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKOFF>(arg0, 6, b"DUCKOFF", b"DUCKOFFSUI", b"This Duck doesnt give a quack!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fqekrf29_400x400_20ed9aec18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

