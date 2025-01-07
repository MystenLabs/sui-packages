module 0x9c402b6dd551e052f24086e9e3533e0879f010527c0cfe3e4e2b153efa31ece7::game {
    struct GameEvent has copy, drop {
        checkerboard: vector<0x1::ascii::String>,
    }

    struct GameSuccessEvent has copy, drop {
        reward: u64,
    }

    struct GameOverEvent has copy, drop {
        loser: 0x1::ascii::String,
    }

    public fun emit(arg0: &vector<vector<0x1::ascii::Char>>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 10) {
            let v2 = 0x1::ascii::string(b"");
            let v3 = 0;
            while (v3 < 20) {
                0x1::ascii::push_char(&mut v2, *0x1::vector::borrow<0x1::ascii::Char>(0x1::vector::borrow<vector<0x1::ascii::Char>>(arg0, v1), v3));
                v3 = v3 + 1;
            };
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v4 = GameEvent{checkerboard: v0};
        0x2::event::emit<GameEvent>(v4);
    }

    public fun confirm_safe(arg0: u64, arg1: u64, arg2: &vector<u8>) : bool {
        let v0 = arg0 * 20 + arg1;
        let v1 = (*0x1::vector::borrow<u8>(arg2, 0) as u64);
        let v2 = (*0x1::vector::borrow<u8>(arg2, 31) as u64);
        let v3 = v0 + 2;
        (((*0x1::vector::borrow<u8>(arg2, v0 % 30 + 1) as u64) * v1 % v3 + v1) * v2 % v3 + v2) * v0 % v3 % 2 == 0
    }

    public fun dfs(arg0: u64, arg1: u64, arg2: &mut vector<vector<0x1::ascii::Char>>, arg3: &vector<u8>) {
        let v0 = b"-";
        if (*0x1::vector::borrow<0x1::ascii::Char>(0x1::vector::borrow<vector<0x1::ascii::Char>>(arg2, arg0), arg1) != 0x1::ascii::char(*0x1::vector::borrow<u8>(&v0, 0))) {
            return
        };
        let v1 = b"0";
        let v2 = *0x1::vector::borrow<u8>(&v1, 0);
        let v3 = 0;
        while (v3 <= 2) {
            let v4 = 0;
            while (v4 <= 2) {
                let v5 = arg0 + v3;
                let v6 = arg1 + v4;
                if (v5 <= 0 || v5 > 10 || v6 <= 0 || v6 > 20) {
                    v4 = v4 + 1;
                    continue
                };
                if (!confirm_safe(v5 - 1, v6 - 1, arg3)) {
                    v2 = v2 + 1;
                };
                v4 = v4 + 1;
            };
            v3 = v3 + 1;
        };
        *0x1::vector::borrow_mut<0x1::ascii::Char>(0x1::vector::borrow_mut<vector<0x1::ascii::Char>>(arg2, arg0), arg1) = 0x1::ascii::char(v2);
        let v7 = b"0";
        if (v2 != *0x1::vector::borrow<u8>(&v7, 0)) {
            return
        };
        v3 = 0;
        while (v3 < 4) {
            let v8 = vector[0, 2, 1, 1];
            let v9 = arg0 + *0x1::vector::borrow<u64>(&v8, v3);
            let v10 = vector[1, 1, 0, 2];
            let v11 = arg1 + *0x1::vector::borrow<u64>(&v10, v3);
            if (v9 <= 0 || v9 > 10 || v11 <= 0 || v11 > 20) {
                v3 = v3 + 1;
                continue
            };
            dfs(v9 - 1, v11 - 1, arg2, arg3);
            v3 = v3 + 1;
        };
    }

    public fun failure_emit(arg0: &vector<vector<0x1::ascii::Char>>) {
        let v0 = GameOverEvent{loser: 0x1::ascii::string(b"Game Over")};
        0x2::event::emit<GameOverEvent>(v0);
        emit(arg0);
    }

    public fun generate_empty_checkerboard() : vector<vector<0x1::ascii::Char>> {
        let v0 = b"-";
        let v1 = 0;
        let v2 = 0x1::vector::empty<0x1::ascii::Char>();
        while (v1 < 20) {
            0x1::vector::push_back<0x1::ascii::Char>(&mut v2, 0x1::ascii::char(*0x1::vector::borrow<u8>(&v0, 0)));
            v1 = v1 + 1;
        };
        v1 = 0;
        let v3 = 0x1::vector::empty<vector<0x1::ascii::Char>>();
        while (v1 < 10) {
            0x1::vector::push_back<vector<0x1::ascii::Char>>(&mut v3, v2);
            v1 = v1 + 1;
        };
        emit(&v3);
        v3
    }

    public fun generate_hash(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg0);
        let v1 = 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1));
        0x2::hmac::hmac_sha3_256(&v0, &v1)
    }

    public fun max_list() : u64 {
        20
    }

    public fun max_row() : u64 {
        10
    }

    public fun open_checkerboard(arg0: &mut vector<vector<0x1::ascii::Char>>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 10) {
            let v1 = 0;
            while (v1 < 20) {
                if (!confirm_safe(v0, v1, arg1)) {
                    let v2 = b"x";
                    *0x1::vector::borrow_mut<0x1::ascii::Char>(0x1::vector::borrow_mut<vector<0x1::ascii::Char>>(arg0, v0), v1) = 0x1::ascii::char(*0x1::vector::borrow<u8>(&v2, 0));
                } else {
                    dfs(v0, v1, arg0, arg1);
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun success_clear(arg0: &vector<vector<0x1::ascii::Char>>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 10) {
            let v1 = 0;
            while (v1 < 20) {
                let v2 = b"-";
                if (*0x1::vector::borrow<0x1::ascii::Char>(0x1::vector::borrow<vector<0x1::ascii::Char>>(arg0, v0), v1) == 0x1::ascii::char(*0x1::vector::borrow<u8>(&v2, 0)) && confirm_safe(v0, v1, arg1)) {
                    return false
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun success_emit(arg0: u64, arg1: &vector<vector<0x1::ascii::Char>>) {
        let v0 = GameSuccessEvent{reward: arg0};
        0x2::event::emit<GameSuccessEvent>(v0);
        emit(arg1);
    }

    // decompiled from Move bytecode v6
}

