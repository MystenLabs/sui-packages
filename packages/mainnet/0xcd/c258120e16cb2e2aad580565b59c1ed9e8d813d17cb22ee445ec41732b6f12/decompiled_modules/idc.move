module 0xcdc258120e16cb2e2aad580565b59c1ed9e8d813d17cb22ee445ec41732b6f12::idc {
    struct IDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDC>(arg0, 6, b"IDC", b"I Dont Care", b"I just dont care", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/idc_0b5ce42f19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

