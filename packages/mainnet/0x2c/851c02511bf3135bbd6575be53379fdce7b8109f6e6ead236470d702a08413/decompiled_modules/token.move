module 0x2c851c02511bf3135bbd6575be53379fdce7b8109f6e6ead236470d702a08413::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UrlConfig has key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
    }

    struct MarketingConfig has key {
        id: 0x2::object::UID,
        wallet: address,
    }

    struct TokenCreated has copy, drop {
        total_supply: u64,
        decimals: u8,
        creator: address,
    }

    struct UrlUpdated has copy, drop {
        old_url: 0x2::url::Url,
        new_url: 0x2::url::Url,
        admin: address,
    }

    struct TokensMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TaxCollected has copy, drop {
        amount: u64,
        from: address,
        marketing_wallet: address,
    }

    struct TokensTransferred has copy, drop {
        from: address,
        to: address,
        amount: u64,
        tax_amount: u64,
    }

    struct AdminCapabilityTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct MarketingWalletUpdated has copy, drop {
        old_wallet: address,
        new_wallet: address,
        admin: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000000000000, 0);
        let v0 = (arg2 as u128) * (1000000 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        let v1 = (v0 as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(arg0, v1, arg4), arg3);
        let v2 = TokensMinted{
            amount    : v1,
            recipient : arg3,
        };
        0x2::event::emit<TokensMinted>(v2);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<TOKEN>, arg1: u64, arg2: address, arg3: &MarketingConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<TOKEN>(arg0) >= arg1, 3);
        let v1 = (arg1 as u128) * (300 as u128) / (10000 as u128);
        assert!(v1 <= 18446744073709551615, 4);
        let v2 = (v1 as u64);
        assert!(arg1 >= v2, 5);
        let v3 = arg1 - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::split<TOKEN>(arg0, v2, arg4), arg3.wallet);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::split<TOKEN>(arg0, v3, arg4), arg2);
        let v4 = TaxCollected{
            amount           : v2,
            from             : v0,
            marketing_wallet : arg3.wallet,
        };
        0x2::event::emit<TaxCollected>(v4);
        let v5 = TokensTransferred{
            from       : v0,
            to         : arg2,
            amount     : v3,
            tax_amount : v2,
        };
        0x2::event::emit<TokensTransferred>(v5);
    }

    public fun get_marketing_wallet(arg0: &MarketingConfig) : address {
        arg0.wallet
    }

    public fun get_url(arg0: &UrlConfig) : &0x2::url::Url {
        &arg0.url
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(3000000000000 <= 10000000000000, 0);
        let v0 = (3000000000000 as u128) * (1000000 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        let v1 = (v0 as u64);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = UrlConfig{
            id  : 0x2::object::new(arg1),
            url : 0x2::url::new_unsafe_from_bytes(b"https://i.imghippo.com/files/AvU8284Tn.png"),
        };
        let v4 = MarketingConfig{
            id     : 0x2::object::new(arg1),
            wallet : 0x2::tx_context::sender(arg1),
        };
        let v5 = 0x2::tx_context::sender(arg1);
        let (v6, v7) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"SQSQ", b"SQUIDSQUIDS", b"SQUIDSQUIDS Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imghippo.com/files/AvU8284Tn.png")), arg1);
        let v8 = v6;
        let v9 = TokenCreated{
            total_supply : v1,
            decimals     : 6,
            creator      : v5,
        };
        0x2::event::emit<TokenCreated>(v9);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v8, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v8, v1, arg1), v5);
        0x2::transfer::public_transfer<AdminCap>(v2, v5);
        0x2::transfer::share_object<UrlConfig>(v3);
        0x2::transfer::share_object<MarketingConfig>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v7);
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapabilityTransferred{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<AdminCapabilityTransferred>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_marketing_wallet(arg0: &AdminCap, arg1: &mut MarketingConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.wallet = arg2;
        let v0 = MarketingWalletUpdated{
            old_wallet : arg1.wallet,
            new_wallet : arg2,
            admin      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<MarketingWalletUpdated>(v0);
    }

    public entry fun update_url(arg0: &AdminCap, arg1: &mut UrlConfig, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(validate_url(arg2), 2);
        let v0 = 0x2::url::new_unsafe_from_bytes(arg2);
        arg1.url = v0;
        let v1 = UrlUpdated{
            old_url : arg1.url,
            new_url : v0,
            admin   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<UrlUpdated>(v1);
    }

    fun validate_url(arg0: vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (v0 < 8) {
            return false
        };
        let v1 = if (v0 >= 8) {
            if (*0x1::vector::borrow<u8>(&arg0, 0) == 104) {
                if (*0x1::vector::borrow<u8>(&arg0, 1) == 116) {
                    if (*0x1::vector::borrow<u8>(&arg0, 2) == 116) {
                        if (*0x1::vector::borrow<u8>(&arg0, 3) == 112) {
                            if (*0x1::vector::borrow<u8>(&arg0, 4) == 115) {
                                if (*0x1::vector::borrow<u8>(&arg0, 5) == 58) {
                                    if (*0x1::vector::borrow<u8>(&arg0, 6) == 47) {
                                        *0x1::vector::borrow<u8>(&arg0, 7) == 47
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
        let v2 = if (v0 >= 7) {
            if (*0x1::vector::borrow<u8>(&arg0, 0) == 104) {
                if (*0x1::vector::borrow<u8>(&arg0, 1) == 116) {
                    if (*0x1::vector::borrow<u8>(&arg0, 2) == 116) {
                        if (*0x1::vector::borrow<u8>(&arg0, 3) == 112) {
                            if (*0x1::vector::borrow<u8>(&arg0, 4) == 58) {
                                if (*0x1::vector::borrow<u8>(&arg0, 5) == 47) {
                                    *0x1::vector::borrow<u8>(&arg0, 6) == 47
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
                }
            } else {
                false
            }
        } else {
            false
        };
        if (!v2 && !v1) {
            return false
        };
        let v3 = if (v1) {
            8
        } else {
            7
        };
        v0 > v3
    }

    // decompiled from Move bytecode v6
}

