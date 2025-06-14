module 0xd5a1b9810d035284c3be0d1a40563d12286390f56d5939b23437ed341ced7306::opf {
    struct OPF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPF>(arg0, 9, b"OPF", b"opf", b"hello", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/a627bef8-28e4-4831-8ad8-abb3150d7e4c.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

