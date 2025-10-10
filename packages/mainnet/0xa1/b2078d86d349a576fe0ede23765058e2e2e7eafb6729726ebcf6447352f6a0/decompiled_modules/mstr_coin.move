module 0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::mstr_coin {
    struct MSTR_COIN has drop {
        dummy_field: bool,
    }

    struct MSTRTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<MSTR_COIN>,
    }

    public entry fun burn(arg0: &mut MSTRTreasury, arg1: &mut 0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::StockRegistry, arg2: 0x2::coin::Coin<MSTR_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<MSTR_COIN>(&arg2);
        0x2::coin::burn<MSTR_COIN>(&mut arg0.cap, arg2);
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::update_supply(arg1, v0, false);
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::emit_burn_event(0x1::string::utf8(b"MSTR"), v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun mint(arg0: &0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::MinterCap, arg1: &mut MSTRTreasury, arg2: &mut 0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::StockRegistry, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"MSTR");
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::verify_mint_authorization(arg0, arg2, &v0, arg7);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg4)) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg4, v2));
            v2 = v2 + 1;
        };
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::record_backing_proof(arg2, arg4, arg5, arg3, arg6, v0, arg7);
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::update_supply(arg2, arg3, true);
        0xa1b2078d86d349a576fe0ede23765058e2e2e7eafb6729726ebcf6447352f6a0::registry::emit_mint_event(0x1::string::utf8(b"MSTR"), arg3, arg6, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MSTR_COIN>>(0x2::coin::mint<MSTR_COIN>(&mut arg1.cap, arg3, arg7), arg6);
    }

    fun init(arg0: MSTR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR_COIN>(arg0, 8, b"MSTRx", b"MicroStrategy Synthetic Stock", b"Synthetic MicroStrategy stock backed 1:1 by Backed Finance MSTR tokens on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreifxqe2gddvnp6wbwdnnncfmv4l4qcz4jf54twpuapwk42b72huyra")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR_COIN>>(v1);
        let v2 = MSTRTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<MSTRTreasury>(v2);
    }

    // decompiled from Move bytecode v6
}

