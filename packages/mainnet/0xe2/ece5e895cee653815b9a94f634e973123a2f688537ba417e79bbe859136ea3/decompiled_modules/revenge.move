module 0xe2ece5e895cee653815b9a94f634e973123a2f688537ba417e79bbe859136ea3::revenge {
    struct REVENGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVENGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REVENGE>(arg0, 6, b"REVENGE", b"Dog Revenge", b"Whatever Your Pain, Call The Dogs. It's Time For Revenge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007396_a02f62e533.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVENGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REVENGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

