module 0x8336bd5cf706ca84235e15d083cf851f70b70271819c1351093cbaefe7123874::idc {
    struct IDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDC>(arg0, 6, b"IDC", b"IDONTCARE", b"I DONT REALLY CARE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kelinci_9329f2cd7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

