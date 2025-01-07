module 0xe76874f45e08d66ac93d480c1ceb9a47bd971ab770ec2ae11b45e3ff3c83305::sdwh {
    struct SDWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDWH>(arg0, 6, b"SDWH", b"SUIdogwifhat", b"Buy a blue dogwifhat to support the community of the legendary dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidwh_a6472a1250.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

