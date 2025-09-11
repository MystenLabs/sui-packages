module 0xfb329a3913fb5b48629ad4d305ce6b88698c5656c122878161353749c80ef7ac::agent {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 9, b"NIGGER", b"NIG", b"niggerniggerniggerniggerniggernigger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiagents-image-store.s3.amazonaws.com/uploads/6416b9d8523848bdb611d7ab7056ca2f.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint<T0>(arg0: &mut AdminCap, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<T0>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

