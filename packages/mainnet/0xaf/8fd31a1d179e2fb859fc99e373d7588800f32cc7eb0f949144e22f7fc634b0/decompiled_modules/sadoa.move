module 0xaf8fd31a1d179e2fb859fc99e373d7588800f32cc7eb0f949144e22f7fc634b0::sadoa {
    struct SADOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADOA>(arg0, 6, b"SADOA", b"asda", b"weq2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/circles_b020d61912.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

