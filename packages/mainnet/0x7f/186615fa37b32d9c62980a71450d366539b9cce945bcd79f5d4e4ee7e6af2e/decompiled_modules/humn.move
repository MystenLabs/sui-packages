module 0x7f186615fa37b32d9c62980a71450d366539b9cce945bcd79f5d4e4ee7e6af2e::humn {
    struct HUMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMN>(arg0, 4, b"Humn", b"Human", b"Humn is decentralized project focused on connecting human values and freedom in the digital world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/MDx1ZhY8/IMG-2756.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUMN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

