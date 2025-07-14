module 0x906d9effbd609d157e0a43c53620bc05b638c8495a5b990fefaf12ec2bc987f9::agent {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 9, b"NIG", b"NIG", b"NIGNIGNIGNIGNIGNIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiagents-image-store.s3.amazonaws.com/uploads/3e2e2bd80b384a68a920b1bb5d87cdbd.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

