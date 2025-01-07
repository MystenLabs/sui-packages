module 0xb7d10a696a72b002b114b3646d3c736635ef56c2992c14a3d14a83e3767b9b4b::suinu {
    struct SUINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINU>(arg0, 6, b"SUINU", b"INU", b"Most Loveable dog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUINU_22849b5f4e.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

