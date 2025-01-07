module 0xd4f07f0a6c3a89e027b90eb23e19a8529fc4988dcb4895a910569f69d3efeb46::luke {
    struct LUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKE>(arg0, 9, b"LUKE", b"Lucky Luke", x"4c75636b79204c756b6520656d626f6469657320746865206c6f6e656c7920616e6420726573746c6573732c206275742075707269676874206865726f206c696b65206e6f206f7468657220636f6d69632063686172616374657220616e6420697320636f6d706c6574656c792064656469636174656420746f2074686520666967687420616761696e737420696e6a7573746963652e20486520697320737570706f7274656420696e2068697320616476656e74757265732062792068697320686f72736520224a6f6c6c79204a756d7065722220616e6420646f6720e2808be2808b2252616e74616e706c616e222e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91365afa-a208-46ee-842e-bae3241a954d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

