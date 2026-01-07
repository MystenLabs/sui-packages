module 0x7e2ca330eefc3699046c5a718c982e223930a8b7afdf909578a4cc80effa216e::SUNNY {
    struct SUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUNNY>(arg0, 6, 0x1::string::utf8(b"SUNNY"), 0x1::string::utf8(b"Sunny Sunny"), 0x1::string::utf8(b"So bright"), 0x1::string::utf8(b"https://arweave.net/ecq1feMp-yjl7UiaUwdu-bmmLciS9yGXLGIViUIQ2Qk"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<SUNNY>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<SUNNY>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUNNY>>(0x2::coin::mint<SUNNY>(&mut v2, 88888888888000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

