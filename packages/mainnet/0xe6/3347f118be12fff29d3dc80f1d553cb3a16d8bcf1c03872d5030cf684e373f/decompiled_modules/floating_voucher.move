module 0xe63347f118be12fff29d3dc80f1d553cb3a16d8bcf1c03872d5030cf684e373f::floating_voucher {
    struct UBH168Packet has copy, drop, store {
        vector_origin: u32,
        zeeman_factor: u16,
        smell_seed: u32,
        genomic_delta: vector<u8>,
        hmac: vector<u8>,
    }

    struct FloatingVoucher has store, key {
        id: 0x2::object::UID,
        owner: address,
        dna_sequence: vector<u8>,
        ubh168_packet: UBH168Packet,
        creation_time: u64,
        float_start_time: u64,
        collateral: 0x2::coin::Coin<0x2::sui::SUI>,
        is_floating: bool,
    }

    struct VoucherRegistry has key {
        id: 0x2::object::UID,
        vouchers: 0x2::table::Table<u64, address>,
        total_vouchers: u64,
    }

    public fun assemble_ubh168_packet(arg0: u32, arg1: u16, arg2: u32, arg3: vector<u8>, arg4: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg1 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg2 & 255) as u8));
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg3)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg3, v1));
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg4)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg4, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun binary_to_braille(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 + 7 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = 0;
            let v3 = 0;
            while (v3 < 8) {
                if (*0x1::vector::borrow<u8>(&arg0, v1 + v3) == 49) {
                    v2 = v2 + (1 << 7 - (v3 as u8));
                };
                v3 = v3 + 1;
            };
            let v4 = 10240 + (v2 as u64);
            0x1::vector::push_back<u8>(&mut v0, ((v4 >> 8 & 255) as u8));
            0x1::vector::push_back<u8>(&mut v0, ((v4 & 255) as u8));
            v1 = v1 + 8;
        };
        v0
    }

    public fun binary_to_dna(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 + 1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            let v3 = *0x1::vector::borrow<u8>(&arg0, v1 + 1);
            if (v2 == 48 && v3 == 48) {
                0x1::vector::push_back<u8>(&mut v0, 65);
            } else if (v2 == 48 && v3 == 49) {
                0x1::vector::push_back<u8>(&mut v0, 67);
            } else if (v2 == 49 && v3 == 48) {
                0x1::vector::push_back<u8>(&mut v0, 71);
            } else if (v2 == 49 && v3 == 49) {
                0x1::vector::push_back<u8>(&mut v0, 84);
            };
            v1 = v1 + 2;
        };
        v0
    }

    public fun calculate_appreciation(arg0: &FloatingVoucher, arg1: u64) : u64 {
        if (!arg0.is_floating) {
            return 0
        };
        (arg1 - arg0.float_start_time) * 1 / 10000
    }

    public entry fun create_voucher(arg0: vector<u8>, arg1: UBH168Packet, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::length<u8>(&arg0) == 64, 1);
        assert!(0x1::vector::length<u8>(&arg1.genomic_delta) == 7, 4);
        assert!(0x1::vector::length<u8>(&arg1.hmac) == 5, 4);
        let v1 = FloatingVoucher{
            id               : 0x2::object::new(arg3),
            owner            : v0,
            dna_sequence     : arg0,
            ubh168_packet    : arg1,
            creation_time    : 0x2::tx_context::epoch(arg3),
            float_start_time : 0,
            collateral       : arg2,
            is_floating      : false,
        };
        0x2::transfer::transfer<FloatingVoucher>(v1, v0);
    }

    public fun dna_to_binary(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 == 65) {
                0x1::vector::push_back<u8>(&mut v0, 48);
                0x1::vector::push_back<u8>(&mut v0, 48);
            } else if (v2 == 67) {
                0x1::vector::push_back<u8>(&mut v0, 48);
                0x1::vector::push_back<u8>(&mut v0, 49);
            } else if (v2 == 71) {
                0x1::vector::push_back<u8>(&mut v0, 49);
                0x1::vector::push_back<u8>(&mut v0, 48);
            } else if (v2 == 84) {
                0x1::vector::push_back<u8>(&mut v0, 49);
                0x1::vector::push_back<u8>(&mut v0, 49);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun extract_ubh168_components(arg0: vector<u8>) : (u32, u16, u32, vector<u8>, vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 21, 4);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 9;
        while (v1 < 16) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        v1 = 16;
        while (v1 < 21) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        ((*0x1::vector::borrow<u8>(&arg0, 0) as u32) << 16 | (*0x1::vector::borrow<u8>(&arg0, 1) as u32) << 8 | (*0x1::vector::borrow<u8>(&arg0, 2) as u32), (*0x1::vector::borrow<u8>(&arg0, 3) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, 4) as u16), (*0x1::vector::borrow<u8>(&arg0, 5) as u32) << 24 | (*0x1::vector::borrow<u8>(&arg0, 6) as u32) << 16 | (*0x1::vector::borrow<u8>(&arg0, 7) as u32) << 8 | (*0x1::vector::borrow<u8>(&arg0, 8) as u32), v0, v2)
    }

    public fun get_dna_sequence(arg0: &FloatingVoucher) : vector<u8> {
        arg0.dna_sequence
    }

    public fun get_genesis_dna() : vector<u8> {
        b"ATCGGCTATAGCCGATGATCCTAGATGCATCGCGTATCGGCTATGCGCATCGTATCGGCTATAGC"
    }

    public fun get_info_888() : vector<u8> {
        b"36n9.888"
    }

    public fun get_info_quantum() : vector<u8> {
        b"36n9.quantum"
    }

    public fun get_info_sonic() : vector<u8> {
        b"36n9.sonic"
    }

    public fun get_metadata_anchors() : (vector<u8>, vector<u8>, vector<u8>, vector<u8>) {
        (b"36n9.888", b"36n9.quantum", b"36n9.sonic", b"G8-Loud-Launch")
    }

    public fun get_owner(arg0: &FloatingVoucher) : address {
        arg0.owner
    }

    public fun get_ubh168_packet(arg0: &FloatingVoucher) : UBH168Packet {
        arg0.ubh168_packet
    }

    public fun get_version() : vector<u8> {
        b"G8-Loud-Launch"
    }

    public entry fun init_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherRegistry{
            id             : 0x2::object::new(arg0),
            vouchers       : 0x2::table::new<u64, address>(arg0),
            total_vouchers : 0,
        };
        0x2::transfer::share_object<VoucherRegistry>(v0);
    }

    public fun is_floating(arg0: &FloatingVoucher) : bool {
        arg0.is_floating
    }

    public entry fun start_float(arg0: &mut FloatingVoucher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(!arg0.is_floating, 2);
        arg0.is_floating = true;
        arg0.float_start_time = 0x2::tx_context::epoch(arg1);
    }

    public entry fun stop_float(arg0: &mut FloatingVoucher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(arg0.is_floating, 3);
        arg0.is_floating = false;
    }

    public entry fun transfer_voucher(arg0: FloatingVoucher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x2::transfer::transfer<FloatingVoucher>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

