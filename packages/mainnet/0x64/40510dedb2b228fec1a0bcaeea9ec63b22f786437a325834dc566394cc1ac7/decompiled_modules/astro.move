module 0x6440510dedb2b228fec1a0bcaeea9ec63b22f786437a325834dc566394cc1ac7::astro {
    struct ASTRO has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public fun register_bridge<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2235d7a739aae888ad6abb290924584a68dd7178a0ae0062237fba9be5666495::tradeport_bridge::Manager, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        0x2235d7a739aae888ad6abb290924584a68dd7178a0ae0062237fba9be5666495::tradeport_bridge::register_bridge<T0, ASTRO>(arg1, 0x2::coin::mint<ASTRO>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<ASTRO>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000, arg2), arg2);
    }

    public fun register_bridge_with_signature<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2235d7a739aae888ad6abb290924584a68dd7178a0ae0062237fba9be5666495::tradeport_bridge::Manager, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        0x2235d7a739aae888ad6abb290924584a68dd7178a0ae0062237fba9be5666495::tradeport_bridge::register_bridge_with_signature<T0, ASTRO>(arg1, arg2, 0x2::coin::mint<ASTRO>(0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<ASTRO>>(&mut arg0.id, 0x1::ascii::string(b"coin_treasury_cap")), 1000000000, arg4), arg3, arg4);
    }

    fun init(arg0: ASTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ASTRO>(arg0, 9, b"ASTRO", b"Astro", b"Liquid NFT Token for AstroBats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.tradeport.gg?url=https%3A%2F%2Ftradeport.mypinata.cloud%2Fipfs%2Fbafkreihnmseo4rjm2u6qtu2ftssolvmvxt5xcfnsyf235rtjic42gvz2we%3FpinataGatewayToken%3D5Uc_j2QFWW75kVPmXB6eWCJ0aVZmc4o9QAq5TiuPfMHZQLKa_VNL3uaXj5NKrq0w%26img-width%3D350%26img-height%3D350%26img-fit%3Dcover%26img-quality%3D80%26img-onerror%3Dredirect%26img-fit%3Dpad%26img-format%3Dwebp&mime-type=image%2Fpng")), true, arg1);
        let v3 = Store{
            id      : 0x2::object::new(arg1),
            version : 1,
            admin   : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASTRO>>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<ASTRO>>(&mut v3.id, 0x1::ascii::string(b"coin_treasury_cap"), v0);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::DenyCapV2<ASTRO>>(&mut v3.id, 0x1::ascii::string(b"coin_deny_cap"), v1);
        0x2::transfer::share_object<Store>(v3);
    }

    entry fun set_admin(arg0: &mut Store, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Store, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Store, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Store) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

