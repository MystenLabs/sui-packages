module 0x9f3f50515100f7f263b38bf0c9108eb532812a76dabcc373267a1a17f13d0bc2::irs {
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

