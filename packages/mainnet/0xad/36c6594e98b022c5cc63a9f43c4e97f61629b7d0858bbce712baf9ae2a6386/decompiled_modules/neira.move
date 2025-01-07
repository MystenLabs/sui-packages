module 0xad36c6594e98b022c5cc63a9f43c4e97f61629b7d0858bbce712baf9ae2a6386::neira {
    struct NEIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRA>(arg0, 6, b"NEIRA", b"Neira", b"Neira is a project for people who love helping dogs around the world, we created an ecosystem specifically for charity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1727231283465_a6734d1d4d74f46830063aa17a31c30e_7b9697bb5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

