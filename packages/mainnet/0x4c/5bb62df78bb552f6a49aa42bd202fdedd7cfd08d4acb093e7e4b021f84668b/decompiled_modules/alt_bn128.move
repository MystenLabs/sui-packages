module 0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::alt_bn128 {
    public fun hash_to_g1(arg0: vector<u8>) : (vector<u8>, u8) {
        let v0 = 0;
        while (v0 < 255) {
            0x1::vector::push_back<u8>(&mut arg0, v0);
            let v1 = 0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::be_bytes_to_u256(0x1::hash::sha2_256(arg0));
            if (v1 < 109441214359196376111232028726286375443481555786489118313445189473226131042915) {
                let v2 = v1 % 21888242871839275222246405745257275088696311157297823662689037894645226208583;
                if (is_valid_compressed_g1(v2)) {
                    return (0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::u256_to_be_bytes(v2), v0)
                };
            };
            v0 = v0 + 1;
        };
        abort 4
    }

    fun is_quadratic_residue(arg0: u256, arg1: u256) : bool {
        let v0 = arg0 % arg1;
        let v1 = v0;
        if (v0 == 0) {
            return false
        };
        let v2 = false;
        while (v1 != 0) {
            while (v1 & 1 == 0) {
                v1 = v1 >> 1;
                let v3 = arg1 & 7;
                if (v3 == 3 || v3 == 5) {
                    v2 = !v2;
                };
            };
            if (arg1 & 3 == 3 && v1 & 3 == 3) {
                v2 = !v2;
            };
            v1 = arg1 % v1;
        };
        arg1 == 1 && !v2
    }

    fun is_quadratic_residue_euler(arg0: u256, arg1: u256) : bool {
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            return false
        };
        let v1 = 1;
        let v2 = arg1 - 1 >> 1;
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                v1 = 0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::mul_mod(v1, v0, arg1);
            };
            v2 = v2 >> 1;
            if (v2 > 0) {
                v0 = 0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::mul_mod(v0, v0, arg1);
            };
        };
        v1 == 1
    }

    fun is_valid_compressed_g1(arg0: u256) : bool {
        is_quadratic_residue(0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::add_mod(0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::mul_mod(0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils::mul_mod(arg0, arg0, 21888242871839275222246405745257275088696311157297823662689037894645226208583), arg0, 21888242871839275222246405745257275088696311157297823662689037894645226208583), 3, 21888242871839275222246405745257275088696311157297823662689037894645226208583), 21888242871839275222246405745257275088696311157297823662689037894645226208583)
    }

    fun is_zero_point(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        assert!(0x1::vector::length<u8>(&arg1) == 64, 2);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        if (is_zero_point(&arg0) || is_zero_point(&arg1)) {
            return false
        };
        0x1::vector::reverse<u8>(&mut arg2);
        0x1::vector::reverse<u8>(&mut arg1);
        0x1::vector::append<u8>(&mut arg2, arg1);
        0x1::vector::append<u8>(&mut arg2, x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400100000000000000000000000000000000000000000000000000000000000000000000000000004006aa5d67636c8b6cd301220a3fefd62e06f6dccaab9fa2c4928e53923ad09f2d2d0084af5bb4685e9b84a6be59f739c8db3c1be2d12c49df2921d69ff507d01885ec7a2bc2cc2e824a98997b32fddbd0081a13bee3da3d2bfa3a594a57999f1391adb05befa3694a7a4946850d2ad3fad47289474e964a202c88e9fa35a988155c0399f2eedc6e239863d9745e68cf46a81a75083545b70d803c8cbc4d2be005612dc573e436661ae91fbe5101a74fda3e1ce3c61711855aba3862bc367cd128be3c487f1e0439e67cf62f610be274931af19a25646ae7e1280d9c16e9d4a11973e0ff4fd1dd13052b89af2a59ef0ef91740fd818efd34ea6918c64e06b0f22c32bfd72f84397801c2398eac9a3820188a6653144437facdb02030dc7647b4137f868fdf84aa3de530a0b3cd069bfdb5a5d67e538089d6b00dc9718010f5f917549ff5a506ff489815c68f2a2c0b8cfc221326d9338c6da4b6be8de8ab81612e4376c57d2cc14ad548fff751ee6918a242d18e94a2ac53c2d1e237956177321f000000000000000001000000000000000001");
        let v0 = 0x2::groth16::bn254();
        0x1::vector::reverse<u8>(&mut arg0);
        0x1::vector::append<u8>(&mut arg0, x"edf692d95cbdde46ddda5ef7d422436779445c5e66006a42761e1f12efde0018c212f3aeb785e49712e7a9353349aaf1255dfb31b7bf60723a480d9293938e19");
        0x1::vector::append<u8>(&mut arg0, x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400100000000000000000000000000000000000000000000000000000000000000000000000000004006aa5d67636c8b6cd301220a3fefd62e06f6dccaab9fa2c4928e53923ad09f2d2d0084af5bb4685e9b84a6be59f739c8db3c1be2d12c49df2921d69ff507d01885ec7a2bc2cc2e824a98997b32fddbd0081a13bee3da3d2bfa3a594a57999f1391adb05befa3694a7a4946850d2ad3fad47289474e964a202c88e9fa35a988155c0399f2eedc6e239863d9745e68cf46a81a75083545b70d803c8cbc4d2be005612dc573e436661ae91fbe5101a74fda3e1ce3c61711855aba3862bc367cd128be3c487f1e0439e67cf62f610be274931af19a25646ae7e1280d9c16e9d4a11973e0ff4fd1dd13052b89af2a59ef0ef91740fd818efd34ea6918c64e06b0f22c32bfd72f84397801c2398eac9a3820188a6653144437facdb02030dc7647b4137f868fdf84aa3de530a0b3cd069bfdb5a5d67e538089d6b00dc9718010f5f917549ff5a506ff489815c68f2a2c0b8cfc221326d9338c6da4b6be8de8ab81612e4376c57d2cc14ad548fff751ee6918a242d18e94a2ac53c2d1e237956177321f000000000000000001000000000000000001");
        let v1 = 0x2::groth16::bn254();
        0x2::groth16::prepare_verifying_key(&v0, &arg2) == 0x2::groth16::prepare_verifying_key(&v1, &arg0)
    }

    // decompiled from Move bytecode v6
}

