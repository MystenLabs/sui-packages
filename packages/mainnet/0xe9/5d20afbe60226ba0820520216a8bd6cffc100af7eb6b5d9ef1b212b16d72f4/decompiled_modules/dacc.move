module 0xe95d20afbe60226ba0820520216a8bd6cffc100af7eb6b5d9ef1b212b16d72f4::dacc {
    struct DACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACC>(arg0, 1, b"DACC", b"DAOS Accelerator", b"DAOS Accelerator vision is to be the launchpad for the most ambitious DAOs within the DAOS.SUI ecosystem. Providing early funding, expert guidance, and strategic support to help DAOs achieve their full potential. Our mission is to empower DAOs to rise from promising ideas to market-leadership. We bridge the gap between great ideas and market-leading DAOs. By investing early and working closely with DAO teams, we ensure their success and help shape the future of decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/0a26fb00-da8f-11ef-80e8-811f7f414973")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DACC>>(v1);
        0x2::coin::mint_and_transfer<DACC>(&mut v2, 11000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

