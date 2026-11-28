module 0x348090e2218fe5243340230b27e612b22a5d59be2d24a7c88357054a6e832585::asset {
    struct ASSET has key {
        id: 0x2::object::UID,
    }

    struct LaunchCap has key {
        id: 0x2::object::UID,
        issuer: address,
    }

    struct Issued has copy, drop {
        issuer: address,
        amount: u64,
        decimals: u8,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LaunchCap{
            id     : 0x2::object::new(arg0),
            issuer : v0,
        };
        0x2::transfer::transfer<LaunchCap>(v1, v0);
    }

    entry fun issue(arg0: LaunchCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let LaunchCap {
            id     : v0,
            issuer : v1,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg8), 2);
        let v2 = if (0x1::vector::length<u8>(&arg2) > 0) {
            if (0x1::vector::length<u8>(&arg2) <= 128) {
                if (0x1::vector::length<u8>(&arg3) >= 2) {
                    if (0x1::vector::length<u8>(&arg3) <= 12) {
                        if (0x1::vector::length<u8>(&arg4) <= 384) {
                            0x1::vector::length<u8>(&arg5) <= 512
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0);
        assert!(arg6 <= 9 && arg7 > 0, 1);
        0x2::object::delete(v0);
        let (v3, v4) = 0x2::coin_registry::new_currency<ASSET>(arg1, arg6, 0x1::string::utf8(arg3), 0x1::string::utf8(arg2), 0x1::string::utf8(arg4), 0x1::string::utf8(arg5), arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::coin_registry::make_supply_fixed_init<ASSET>(&mut v6, v5);
        0x2::coin_registry::finalize_and_delete_metadata_cap<ASSET>(v6, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<ASSET>>(0x2::coin::mint<ASSET>(&mut v5, arg7, arg8), v1);
        let v7 = Issued{
            issuer   : v1,
            amount   : arg7,
            decimals : arg6,
        };
        0x2::event::emit<Issued>(v7);
    }

    // decompiled from Move bytecode v7
}

