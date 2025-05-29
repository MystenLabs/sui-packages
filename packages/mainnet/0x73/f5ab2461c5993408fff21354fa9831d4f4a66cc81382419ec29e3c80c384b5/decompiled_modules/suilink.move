module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink {
    struct SUILINK has drop {
        dummy_field: bool,
    }

    struct SuiLink<phantom T0> has key {
        id: 0x2::object::UID,
        network_address: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiLinkRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::vec_set::VecSet<vector<u8>>,
    }

    public fun delete<T0>(arg0: &mut SuiLinkRegistry, arg1: SuiLink<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun transfer<T0>(arg0: SuiLink<T0>, arg1: address) {
        0x2::transfer::transfer<SuiLink<T0>>(arg0, arg1);
    }

    public(friend) fun destroy<T0>(arg0: SuiLink<T0>) : 0x1::string::String {
        let SuiLink {
            id              : v0,
            network_address : v1,
            timestamp_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun destroy_registry(arg0: SuiLinkRegistry) : 0x2::vec_set::VecSet<vector<u8>> {
        let SuiLinkRegistry {
            id       : v0,
            registry : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    fun init(arg0: SUILINK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUILINK>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = SuiLinkRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<SuiLinkRegistry>(v1);
    }

    public(friend) fun mint<T0>(arg0: 0x1::string::String, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SuiLink<T0> {
        SuiLink<T0>{
            id              : 0x2::object::new(arg2),
            network_address : arg0,
            timestamp_ms    : arg1,
        }
    }

    public fun network_address<T0>(arg0: &SuiLink<T0>) : 0x1::string::String {
        arg0.network_address
    }

    public(friend) fun nullify_network_address<T0>(arg0: &mut SuiLink<T0>) {
        arg0.network_address = 0x1::string::utf8(b"");
    }

    public(friend) fun nullify_timestamp_ms<T0>(arg0: &mut SuiLink<T0>) {
        arg0.timestamp_ms = 0;
    }

    public fun timestamp_ms<T0>(arg0: &SuiLink<T0>) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun transfer_receive<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::transfer::Receiving<SuiLink<T0>>) : SuiLink<T0> {
        0x2::transfer::receive<SuiLink<T0>>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

