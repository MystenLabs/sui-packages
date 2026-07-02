module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::blackjack_cards {
    public fun dealer_should_hit(arg0: &vector<u8>) : bool {
        let (v0, _) = hand_total(arg0);
        v0 < 17
    }

    public fun hand_total(arg0: &vector<u8>) : (u8, bool) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            v0 = v0 + (rank_value(v3) as u16);
            if (rank_idx(v3) == 0) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v1 > 0 && v0 + 10 <= 21) {
            v0 = v0 + 10;
            v1 = v1 - 1;
            v4 = v4 + 1;
        };
        let v5 = if (v0 > 31) {
            31
        } else {
            (v0 as u8)
        };
        (v5, v4 > 0)
    }

    public fun is_blackjack(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 2) {
            return false
        };
        let (v0, _) = hand_total(arg0);
        v0 == 21
    }

    public fun is_bust(arg0: &vector<u8>) : bool {
        let (v0, _) = hand_total(arg0);
        v0 > 21
    }

    public fun new_deck() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 52) {
            0x1::vector::push_back<u8>(&mut v0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun rank_idx(arg0: u8) : u8 {
        assert!(arg0 < 52, 1);
        arg0 % 13
    }

    public fun rank_value(arg0: u8) : u8 {
        let v0 = rank_idx(arg0);
        if (v0 == 0) {
            1
        } else if (v0 <= 8) {
            v0 + 1
        } else {
            10
        }
    }

    public fun suit(arg0: u8) : u8 {
        assert!(arg0 < 52, 1);
        arg0 / 13
    }

    // decompiled from Move bytecode v7
}

