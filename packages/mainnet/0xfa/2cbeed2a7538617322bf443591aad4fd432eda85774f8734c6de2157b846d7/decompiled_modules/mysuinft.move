module 0xfa2cbeed2a7538617322bf443591aad4fd432eda85774f8734c6de2157b846d7::mysuinft {
    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        creator: address,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        price: u64,
        recipient: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct PriceUpdated has copy, drop {
        updater: address,
        new_price: u64,
    }

    struct NFTBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
    }

    struct MYSUINFT has drop {
        dummy_field: bool,
    }

    public entry fun admin_mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) <= 10, 4);
        assert!(validate_url(&arg3), 3);
        let v0 = 0x2::tx_context::sender(arg6);
        create_and_transfer_nft(arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public fun attributes_keys(arg0: &Nft) : &vector<0x1::string::String> {
        &arg0.attribute_keys
    }

    public fun attributes_values(arg0: &Nft) : &vector<0x1::string::String> {
        &arg0.attribute_values
    }

    public entry fun burn(arg0: Nft, arg1: &mut 0x2::tx_context::TxContext) {
        let Nft {
            id               : v0,
            name             : _,
            description      : _,
            image_url        : _,
            creator          : v4,
            attribute_keys   : _,
            attribute_values : _,
        } = arg0;
        let v7 = v0;
        let v8 = NFTBurned{
            object_id : 0x2::object::id_from_address(0x2::object::uid_to_address(&v7)),
            owner     : v4,
        };
        0x2::event::emit<NFTBurned>(v8);
        0x2::object::delete(v7);
    }

    fun create_and_transfer_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id               : 0x2::object::new(arg6),
            name             : arg0,
            description      : arg1,
            image_url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg2)),
            creator          : arg5,
            attribute_keys   : arg3,
            attribute_values : arg4,
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v0),
            creator   : arg5,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<Nft>(v0, arg5);
    }

    public fun description(arg0: &Nft) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &Nft) : 0x2::url::Url {
        arg0.image_url
    }

    fun init(arg0: MYSUINFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfff953ec5eac874d97ef8b771f9b2bda6eeaf633197784838b45c66ad8cbabe;
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, @0xdb8cbeb195e772d2e7d76d7f5a310b8f0c146c5048dab479007187a510db034);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, @0x74cbd2a79481dfb0a1d6e8eca1663b262c8c868d9dab393d2c3986c9602e3684);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, @0xf61e513d0346d81fa13aedf9dcc6a3febd021b764acff2da4284b777d384cd9e);
        let v5 = Config{
            id        : 0x2::object::new(arg1),
            price     : 250000000,
            recipient : v0,
        };
        0x2::transfer::share_object<Config>(v5);
        let v6 = 0x2::package::claim<MYSUINFT>(arg0, arg1);
        let v7 = 0x2::display::new<Nft>(&v6, arg1);
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"attribute_keys"), 0x1::string::utf8(b"{attribute_keys}"));
        0x2::display::add<Nft>(&mut v7, 0x1::string::utf8(b"attribute_values"), 0x1::string::utf8(b"{attribute_values}"));
        0x2::display::update_version<Nft>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v7, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &Config, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg0.price, 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) <= 10, 4);
        assert!(validate_url(&arg3), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, arg0.recipient);
        let v0 = 0x2::tx_context::sender(arg7);
        create_and_transfer_nft(arg1, arg2, arg3, arg4, arg5, v0, arg7);
    }

    public fun name(arg0: &Nft) : 0x1::string::String {
        arg0.name
    }

    public fun price(arg0: &Config) : u64 {
        arg0.price
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
        let v0 = PriceUpdated{
            updater   : 0x2::tx_context::sender(arg3),
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    fun validate_url(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) < 7) {
            return false
        };
        let v1 = 104;
        let v2 = if (0x1::vector::borrow<u8>(v0, 0) == &v1) {
            let v3 = 116;
            if (0x1::vector::borrow<u8>(v0, 1) == &v3) {
                let v4 = 116;
                if (0x1::vector::borrow<u8>(v0, 2) == &v4) {
                    let v5 = 112;
                    if (0x1::vector::borrow<u8>(v0, 3) == &v5) {
                        let v6 = 58;
                        if (0x1::vector::borrow<u8>(v0, 4) == &v6) {
                            let v7 = 47;
                            if (0x1::vector::borrow<u8>(v0, 5) == &v7) {
                                let v8 = 47;
                                0x1::vector::borrow<u8>(v0, 6) == &v8
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
        let v9 = 104;
        let v10 = if (0x1::vector::borrow<u8>(v0, 0) == &v9) {
            let v11 = 116;
            if (0x1::vector::borrow<u8>(v0, 1) == &v11) {
                let v12 = 116;
                if (0x1::vector::borrow<u8>(v0, 2) == &v12) {
                    let v13 = 112;
                    if (0x1::vector::borrow<u8>(v0, 3) == &v13) {
                        let v14 = 115;
                        if (0x1::vector::borrow<u8>(v0, 4) == &v14) {
                            let v15 = 58;
                            if (0x1::vector::borrow<u8>(v0, 5) == &v15) {
                                let v16 = 47;
                                0x1::vector::borrow<u8>(v0, 6) == &v16
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
        v2 || v10
    }

    // decompiled from Move bytecode v6
}

