module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::ausd {
    struct AUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<AUSD>(arg0, 6, b"AUSD", b"AUSD", b"AUSD is a digital dollar issued by Agora", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.agora.finance/ausd-token-icon.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUSD>>(v2);
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::share<AUSD>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::setup::setup<AUSD>(v0, v1, arg1));
    }

    // decompiled from Move bytecode v6
}

