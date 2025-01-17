module 0xcbe9ca8cee83ee454cbc114b8f9825b49ed945f89e6ef4f26a07417a10525f42::zktls {
    struct Attestation has copy, drop, store {
        recipient: vector<u8>,
        request: AttNetworkRequest,
        reponseResolve: vector<AttNetworkResponseResolve>,
        data: 0x1::string::String,
        attConditions: 0x1::string::String,
        timestamp: u64,
        additionParams: 0x1::string::String,
        attestors: vector<Attestor>,
        signatures: vector<vector<u8>>,
    }

    struct AttNetworkRequest has copy, drop, store {
        url: 0x1::string::String,
        header: 0x1::string::String,
        method: 0x1::string::String,
        body: 0x1::string::String,
    }

    struct AttNetworkResponseResolve has copy, drop, store {
        keyName: 0x1::string::String,
        parseType: 0x1::string::String,
        parsePath: 0x1::string::String,
    }

    struct Attestor has copy, drop, store {
        attestorAddr: vector<u8>,
        url: 0x1::string::String,
    }

    struct AddAttestor has copy, drop {
        _address: vector<u8>,
        _attestor: Attestor,
    }

    struct DelAttestor has copy, drop {
        _address: vector<u8>,
    }

    struct PrimusZKTLS has key {
        id: 0x2::object::UID,
        owner: address,
        _attestorsMapping: 0x2::table::Table<vector<u8>, Attestor>,
        _attestors: vector<Attestor>,
    }

    fun new(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : PrimusZKTLS {
        let v0 = PrimusZKTLS{
            id                : 0x2::object::new(arg2),
            owner             : arg0,
            _attestorsMapping : 0x2::table::new<vector<u8>, Attestor>(arg2),
            _attestors        : 0x1::vector::empty<Attestor>(),
        };
        let v1 = &mut v0;
        initialize(v1, arg1);
        v0
    }

    public fun createAttNetworkRequest(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : AttNetworkRequest {
        AttNetworkRequest{
            url    : arg0,
            header : arg1,
            method : arg2,
            body   : arg3,
        }
    }

    public fun createAttNetworkResponseResolve(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : AttNetworkResponseResolve {
        AttNetworkResponseResolve{
            keyName   : arg0,
            parseType : arg1,
            parsePath : arg2,
        }
    }

    public fun createAttestation(arg0: vector<u8>, arg1: AttNetworkRequest, arg2: vector<AttNetworkResponseResolve>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: vector<Attestor>, arg8: vector<vector<u8>>) : Attestation {
        Attestation{
            recipient      : arg0,
            request        : arg1,
            reponseResolve : arg2,
            data           : arg3,
            attConditions  : arg4,
            timestamp      : arg5,
            additionParams : arg6,
            attestors      : arg7,
            signatures     : arg8,
        }
    }

    public fun createAttestor(arg0: vector<u8>, arg1: 0x1::string::String) : Attestor {
        Attestor{
            attestorAddr : arg0,
            url          : arg1,
        }
    }

    public fun createPrimusZktls(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PrimusZKTLS>(new(arg0, arg1, arg2));
    }

    public fun encodeAttestation(arg0: Attestation) : vector<u8> {
        let v0 = encodeAttestationWithoutHash(arg0);
        0x2::hash::keccak256(&v0)
    }

    public fun encodeAttestationWithoutHash(arg0: Attestation) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0.recipient);
        0x1::vector::append<u8>(&mut v0, encodeRequest(arg0.request));
        0x1::vector::append<u8>(&mut v0, encodeResponse(arg0.reponseResolve));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg0.data));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg0.attConditions));
        0x1::vector::append<u8>(&mut v0, 0xcbe9ca8cee83ee454cbc114b8f9825b49ed945f89e6ef4f26a07417a10525f42::utils::u64_to_bytes(arg0.timestamp));
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg0.additionParams));
        v0
    }

    public fun encodeRequest(arg0: AttNetworkRequest) : vector<u8> {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0.url);
        0x1::string::append(&mut v0, arg0.header);
        0x1::string::append(&mut v0, arg0.method);
        0x1::string::append(&mut v0, arg0.body);
        0x2::hash::keccak256(0x1::string::as_bytes(&v0))
    }

    public fun encodeResponse(arg0: vector<AttNetworkResponseResolve>) : vector<u8> {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0;
        while (v1 < 0x1::vector::length<AttNetworkResponseResolve>(&arg0)) {
            let v2 = 0x1::vector::borrow<AttNetworkResponseResolve>(&arg0, v1);
            0x1::string::append(&mut v0, v2.keyName);
            0x1::string::append(&mut v0, v2.parseType);
            0x1::string::append(&mut v0, v2.parsePath);
            v1 = v1 + 1;
        };
        0x2::hash::keccak256(0x1::string::as_bytes(&v0))
    }

    fun initialize(arg0: &mut PrimusZKTLS, arg1: vector<u8>) {
        setupDefaultAttestor(arg0, arg1);
    }

    public fun removeAttestor(arg0: &mut PrimusZKTLS, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4098);
        assert!(arg1 != b"", 4097);
        assert!(0x2::table::contains<vector<u8>, Attestor>(&arg0._attestorsMapping, arg1), 4099);
        0x2::table::remove<vector<u8>, Attestor>(&mut arg0._attestorsMapping, arg1);
        let v0 = 0;
        let v1 = 0x1::vector::length<Attestor>(&arg0._attestors);
        while (v0 < v1) {
            if (0x1::vector::borrow<Attestor>(&arg0._attestors, v0).attestorAddr == arg1) {
                0x1::vector::swap<Attestor>(&mut arg0._attestors, v0, v1 - 1);
                0x1::vector::pop_back<Attestor>(&mut arg0._attestors);
                break
            };
            v0 = v0 + 1;
        };
        let v2 = DelAttestor{_address: arg1};
        0x2::event::emit<DelAttestor>(v2);
    }

    public fun setAttestor(arg0: &mut PrimusZKTLS, arg1: Attestor, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4098);
        assert!(arg1.attestorAddr != b"", 4097);
        if (0x2::table::contains<vector<u8>, Attestor>(&arg0._attestorsMapping, arg1.attestorAddr)) {
            *0x2::table::borrow_mut<vector<u8>, Attestor>(&mut arg0._attestorsMapping, arg1.attestorAddr) = arg1;
            let v0 = 0;
            while (v0 < 0x1::vector::length<Attestor>(&arg0._attestors)) {
                let v1 = 0x1::vector::borrow_mut<Attestor>(&mut arg0._attestors, v0);
                if (v1.attestorAddr == arg1.attestorAddr) {
                    *v1 = arg1;
                    break
                };
                v0 = v0 + 1;
            };
        } else {
            0x2::table::add<vector<u8>, Attestor>(&mut arg0._attestorsMapping, arg1.attestorAddr, arg1);
            0x1::vector::push_back<Attestor>(&mut arg0._attestors, arg1);
        };
        let v2 = AddAttestor{
            _address  : arg1.attestorAddr,
            _attestor : arg1,
        };
        0x2::event::emit<AddAttestor>(v2);
    }

    fun setupDefaultAttestor(arg0: &mut PrimusZKTLS, arg1: vector<u8>) {
        assert!(arg1 != b"", 4097);
        let v0 = Attestor{
            attestorAddr : arg1,
            url          : 0x1::string::utf8(b"https://primuslabs.xyz/"),
        };
        0x2::table::add<vector<u8>, Attestor>(&mut arg0._attestorsMapping, arg1, v0);
        0x1::vector::push_back<Attestor>(&mut arg0._attestors, v0);
    }

    public fun verifyAttestation(arg0: &PrimusZKTLS, arg1: Attestation) {
        assert!(0x1::vector::length<vector<u8>>(&arg1.signatures) == 1, 4100);
        let v0 = *0x1::vector::borrow<vector<u8>>(&arg1.signatures, 0);
        assert!(0x1::vector::length<u8>(&v0) == 65, 4101);
        let v1 = 0;
        let v2 = 0x1::vector::length<Attestor>(&arg0._attestors);
        while (v1 < v2) {
            if (0x1::vector::borrow<Attestor>(&arg0._attestors, v1).attestorAddr == 0xcbe9ca8cee83ee454cbc114b8f9825b49ed945f89e6ef4f26a07417a10525f42::utils::ecrecover_to_eth_address(v0, encodeAttestationWithoutHash(arg1))) {
                break
            };
            v1 = v1 + 1;
        };
        assert!(v1 < v2, 4102);
    }

    // decompiled from Move bytecode v6
}

