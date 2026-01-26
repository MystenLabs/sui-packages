module 0x59409c23c396a9c5760a422cf509ea6d284c31161b6275a3a96b92d2b5e7c97a::voybit_split_pay {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u16,
        fee_collector: address,
        signer_pubkey: vector<u8>,
        paid: 0x2::table::Table<u64, vector<u8>>,
    }

    struct SignedPayment has drop, store {
        config_id: address,
        invoice_id: vector<u8>,
        merchant: address,
        amount: u64,
        expires_at: u64,
    }

    fun bytes_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    fun first8_to_u64(arg0: &vector<u8>) : u64 {
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 7) as u64)
    }

    public entry fun init_shared(arg0: address, arg1: vector<u8>, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = Config{
            id            : 0x2::object::new(arg3),
            fee_bps       : arg2,
            fee_collector : arg0,
            signer_pubkey : arg1,
            paid          : 0x2::table::new<u64, vector<u8>>(arg3),
        };
        0x2::transfer::share_object<Config>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun pay_sui(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg5 != 0 && 0x2::clock::timestamp_ms(arg7) / 1000 > arg5) {
            abort 3
        };
        let v0 = SignedPayment{
            config_id  : 0x2::object::id_address<Config>(arg0),
            invoice_id : arg2,
            merchant   : arg3,
            amount     : arg4,
            expires_at : arg5,
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) != arg4) {
            abort 4
        };
        let v1 = 0x1::bcs::to_bytes<SignedPayment>(&v0);
        if (!0x2::ed25519::ed25519_verify(&arg6, &arg0.signer_pubkey, &v1)) {
            abort 1
        };
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = first8_to_u64(&v2);
        if (0x2::table::contains<u64, vector<u8>>(&arg0.paid, v3)) {
            assert!(!bytes_equal(0x2::table::borrow<u64, vector<u8>>(&arg0.paid, v3), &v2), 2);
            abort 5
        };
        0x2::table::add<u64, vector<u8>>(&mut arg0.paid, v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, (((arg4 as u128) * (arg0.fee_bps as u128) / 10000) as u64), arg8), arg0.fee_collector);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0.merchant);
    }

    public entry fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        arg1.fee_bps = arg2;
    }

    public entry fun set_fee_collector(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_collector = arg2;
    }

    public entry fun set_signer_pubkey(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        arg1.signer_pubkey = arg2;
    }

    // decompiled from Move bytecode v6
}

