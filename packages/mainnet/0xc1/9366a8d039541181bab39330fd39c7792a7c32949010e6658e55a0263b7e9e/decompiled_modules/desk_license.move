module 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license {
    struct DeskLicense has key {
        id: 0x2::object::UID,
        template_id: 0x1::string::String,
        version: 0x1::string::String,
        order_id: 0x1::string::String,
        issued_ms: u64,
        url: 0x1::string::String,
    }

    struct DeskLicenseMinted has copy, drop {
        license_id: 0x2::object::ID,
        template_id: 0x1::string::String,
        order_id: 0x1::string::String,
        recipient: address,
    }

    struct DeskMinter has store, key {
        id: 0x2::object::UID,
        legacy_cap: 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::MinterCap,
    }

    struct MinterLocked has copy, drop {
        desk_minter: 0x2::object::ID,
        legacy_cap: 0x2::object::ID,
    }

    public fun check_policy(arg0: &vector<u8>, arg1: &DeskLicense) : bool {
        if (!is_desk_id(arg0)) {
            return false
        };
        let v0 = 0x1::string::as_bytes(&arg1.template_id);
        let v1 = 0x1::vector::length<u8>(v0);
        if (0x1::vector::length<u8>(arg0) <= 5 + v1 + 1) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, 5 + v2) != *0x1::vector::borrow<u8>(v0, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        *0x1::vector::borrow<u8>(arg0, 5 + v1) == 58
    }

    public fun is_desk_id(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) > 5) {
            if (*0x1::vector::borrow<u8>(arg0, 0) == 100) {
                if (*0x1::vector::borrow<u8>(arg0, 1) == 101) {
                    if (*0x1::vector::borrow<u8>(arg0, 2) == 115) {
                        if (*0x1::vector::borrow<u8>(arg0, 3) == 107) {
                            *0x1::vector::borrow<u8>(arg0, 4) == 58
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
    }

    public fun issue(arg0: &DeskMinter, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(valid_sku(&arg1), 3);
        let v0 = DeskLicense{
            id          : 0x2::object::new(arg7),
            template_id : arg1,
            version     : arg2,
            order_id    : arg3,
            issued_ms   : 0x2::clock::timestamp_ms(arg6),
            url         : arg4,
        };
        let v1 = DeskLicenseMinted{
            license_id  : 0x2::object::id<DeskLicense>(&v0),
            template_id : v0.template_id,
            order_id    : v0.order_id,
            recipient   : arg5,
        };
        0x2::event::emit<DeskLicenseMinted>(v1);
        0x2::transfer::transfer<DeskLicense>(v0, arg5);
    }

    public fun issued_ms(arg0: &DeskLicense) : u64 {
        arg0.issued_ms
    }

    public fun lock_minter(arg0: 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::MinterCap, arg1: &mut 0x2::tx_context::TxContext) : DeskMinter {
        let v0 = DeskMinter{
            id         : 0x2::object::new(arg1),
            legacy_cap : arg0,
        };
        let v1 = MinterLocked{
            desk_minter : 0x2::object::id<DeskMinter>(&v0),
            legacy_cap  : 0x2::object::id<0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::MinterCap>(&arg0),
        };
        0x2::event::emit<MinterLocked>(v1);
        v0
    }

    public fun mint(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::license::MinterCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    public fun order_id(arg0: &DeskLicense) : 0x1::string::String {
        arg0.order_id
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &DeskLicense) {
        assert!(check_policy(&arg0, arg1), 1);
    }

    public fun template_id(arg0: &DeskLicense) : 0x1::string::String {
        arg0.template_id
    }

    public fun url(arg0: &DeskLicense) : 0x1::string::String {
        arg0.url
    }

    public fun valid_sku(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = if (v1 == 0) {
            true
        } else if (v1 > 64) {
            true
        } else {
            *v0 == b"desk"
        };
        if (v2) {
            return false
        };
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(v0, v3);
            let v5 = if (v4 >= 97 && v4 <= 122) {
                true
            } else if (v4 >= 48 && v4 <= 57) {
                true
            } else {
                v4 == 45
            };
            if (!v5) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun version(arg0: &DeskLicense) : 0x1::string::String {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

