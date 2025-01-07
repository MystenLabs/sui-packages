module 0x7462eea184832da98448deed90eb1f21322d1dcc05cfda6d94ae5cc0735b082d::irs {
    struct IRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRS>(arg0, 6, b"IRS", b"International Retardio Syndicate", b"Fuck em.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_06887db9cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

