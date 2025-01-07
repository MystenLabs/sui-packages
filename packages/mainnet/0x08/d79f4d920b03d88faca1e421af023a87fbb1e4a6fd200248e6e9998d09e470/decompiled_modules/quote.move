module 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::quote {
    struct Quote has key {
        id: 0x2::object::UID,
        node_addr: address,
        node_authority: address,
        queue_addr: address,
        quote_buffer: vector<u8>,
        verification_status: u8,
        verification_timestamp: u64,
        valid_until: u64,
        content_hash_enabled: bool,
        friend_key: vector<u8>,
        version: u64,
    }

    public fun new<T0>(arg0: address, arg1: address, arg2: address, arg3: vector<u8>, arg4: bool, arg5: &T0, arg6: &mut 0x2::tx_context::TxContext) : Quote {
        Quote{
            id                     : 0x2::object::new(arg6),
            node_addr              : arg0,
            node_authority         : arg1,
            queue_addr             : arg2,
            quote_buffer           : arg3,
            verification_status    : 0,
            verification_timestamp : 0,
            valid_until            : 0,
            content_hash_enabled   : arg4,
            friend_key             : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>(),
            version                : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(),
        }
    }

    public fun VERIFICATION_FAILURE() : u8 {
        1
    }

    public fun VERIFICATION_OVERRIDE() : u8 {
        3
    }

    public fun VERIFICATION_PENDING() : u8 {
        0
    }

    public fun VERIFICATION_SUCCESS() : u8 {
        2
    }

    public fun fail<T0>(arg0: &mut Quote, arg1: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.verification_status = VERIFICATION_FAILURE();
    }

    public fun force_override<T0>(arg0: &mut Quote, arg1: u64, arg2: u64, arg3: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.verification_status = VERIFICATION_OVERRIDE();
        arg0.valid_until = arg1;
        arg0.verification_timestamp = arg2;
    }

    public fun is_valid(arg0: &Quote, arg1: u64) : bool {
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        if (arg0.verification_status == VERIFICATION_SUCCESS()) {
            return true
        };
        if (arg0.verification_status == VERIFICATION_OVERRIDE()) {
            return true
        };
        if (arg0.verification_status == VERIFICATION_PENDING()) {
            return false
        };
        if (arg0.verification_status == VERIFICATION_FAILURE()) {
            return false
        };
        if (arg0.valid_until < arg1) {
            return false
        };
        false
    }

    entry fun migrate(arg0: &mut Quote, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::AdminCap) {
        assert!(arg0.version < 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.version = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version();
    }

    public fun migrate_package<T0, T1>(arg0: &mut Quote, arg1: &T0, arg2: &T1) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        arg0.friend_key = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T1>();
    }

    public fun node_addr(arg0: &Quote) : address {
        arg0.node_addr
    }

    public fun node_authority(arg0: &Quote) : address {
        arg0.node_authority
    }

    public fun queue_addr(arg0: &Quote) : address {
        arg0.queue_addr
    }

    public fun quote_address(arg0: &Quote) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun quote_buffer(arg0: &Quote) : &vector<u8> {
        &arg0.quote_buffer
    }

    public fun set_configs<T0>(arg0: &mut Quote, arg1: address, arg2: address, arg3: address, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.node_addr = arg1;
        arg0.node_authority = arg2;
        arg0.queue_addr = arg3;
        arg0.quote_buffer = arg4;
        arg0.verification_status = arg5;
        arg0.verification_timestamp = arg6;
        arg0.valid_until = arg7;
    }

    public fun share_quote(arg0: Quote) {
        0x2::transfer::share_object<Quote>(arg0);
    }

    public fun valid_until(arg0: &Quote) : u64 {
        arg0.valid_until
    }

    public fun verification_status(arg0: &Quote) : u8 {
        arg0.verification_status
    }

    public fun verification_timestamp(arg0: &Quote) : u64 {
        arg0.verification_timestamp
    }

    public fun verify<T0>(arg0: &mut Quote, arg1: u64, arg2: u64, arg3: &T0) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::type_of<T0>();
        assert!(&arg0.friend_key == &v0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidPackage());
        assert!(arg0.version == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::switchboard::version(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidVersion());
        arg0.verification_status = VERIFICATION_SUCCESS();
        arg0.verification_timestamp = arg2;
        arg0.valid_until = arg1;
    }

    public fun verify_quote_data(arg0: &Quote) : (bool, vector<u8>) {
        let (v0, v1) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::parse_sgx_quote(&arg0.quote_buffer);
        let v2 = v1;
        if (!arg0.content_hash_enabled) {
            assert!(0x1::hash::sha2_256(0x1::bcs::to_bytes<address>(&arg0.node_authority)) == 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils::slice(&v2, 0, 32), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        };
        (arg0.content_hash_enabled, v0)
    }

    // decompiled from Move bytecode v6
}

