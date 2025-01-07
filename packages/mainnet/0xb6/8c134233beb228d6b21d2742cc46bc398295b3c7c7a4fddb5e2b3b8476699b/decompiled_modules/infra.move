module 0xb68c134233beb228d6b21d2742cc46bc398295b3c7c7a4fddb5e2b3b8476699b::infra {
    struct INFRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<INFRA>(arg0, 6, b"INFRA", b"InfraAI by SuiAI", b"A one-stop-shop solution to your AI, GPU and Cloud compute needs. .Powering the future of AI through Distributed Compute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Lj_F_Lvh_IO_400x400_cc3ccc420a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INFRA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFRA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

