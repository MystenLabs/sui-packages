module 0xa84addf50c5c688bc20e9b60c75e31130383074a3bcc2008d92c5a6b7d681b3e::lockin {
    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
    }

    struct EnclaveConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pcrs: Pcrs,
        capability_id: 0x2::object::ID,
        version: u64,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
    }

    struct LOCKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Cap{id: 0x2::object::new(arg1)};
        let v1 = Pcrs{
            pos0 : x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
            pos1 : x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
            pos2 : x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
        };
        let v2 = EnclaveConfig{
            id            : 0x2::object::new(arg1),
            name          : 0x1::string::utf8(b"seal"),
            pcrs          : v1,
            capability_id : 0x2::object::uid_to_inner(&v0.id),
            version       : 0,
        };
        0x2::transfer::share_object<EnclaveConfig>(v2);
        0x2::transfer::public_transfer<Cap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun name(arg0: &EnclaveConfig) : &0x1::string::String {
        &arg0.name
    }

    public fun pcr0(arg0: &EnclaveConfig) : &vector<u8> {
        &arg0.pcrs.pos0
    }

    public fun pcr1(arg0: &EnclaveConfig) : &vector<u8> {
        &arg0.pcrs.pos1
    }

    public fun pcr2(arg0: &EnclaveConfig) : &vector<u8> {
        &arg0.pcrs.pos2
    }

    public fun update_name(arg0: &mut EnclaveConfig, arg1: &Cap, arg2: 0x1::string::String) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.capability_id, 0);
        arg0.name = arg2;
    }

    public fun update_pcrs(arg0: &mut EnclaveConfig, arg1: &Cap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(0x2::object::uid_to_inner(&arg1.id) == arg0.capability_id, 0);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
        };
        arg0.pcrs = v0;
        arg0.version = arg0.version + 1;
    }

    public fun version(arg0: &EnclaveConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

