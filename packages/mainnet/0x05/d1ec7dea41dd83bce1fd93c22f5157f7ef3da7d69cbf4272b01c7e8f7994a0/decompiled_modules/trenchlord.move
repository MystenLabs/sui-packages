module 0x5d1ec7dea41dd83bce1fd93c22f5157f7ef3da7d69cbf4272b01c7e8f7994a0::trenchlord {
    struct TRENCHLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHLORD>(arg0, 6, b"TRENCHLORD", b"Trenchlord", x"5765616b2068616e6473207472656d626c652c20627574205452454e43484c4f5244207374616e647320756e7368616b656e2c20677265656e2063616e646c6573206c696768742074686520706174682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trenchlord_logo_21cf56ea8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCHLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

