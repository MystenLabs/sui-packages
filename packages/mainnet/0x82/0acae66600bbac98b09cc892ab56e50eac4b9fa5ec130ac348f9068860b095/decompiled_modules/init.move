module 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<INIT>(&arg0), 13906834238767890431);
        let (v0, v1) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::create(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>>(v2, 0x2::tx_context::sender(arg1));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::share_registry(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::market::create_registry(&v3, &v2, arg1));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::timelock::share(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::timelock::create(arg1));
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::share(v3);
    }

    // decompiled from Move bytecode v7
}

