module 0x5c860abaf0e9142d6aa83df071679ac522936136ba0fcf5718b07a03977a25d4::sahur {
    struct SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DNrmDMs2czDaAwgzg2BmvM7Jn5ZqA6VN5huRqCrSpump.png?claimId=XTv3l4dv4oEV_sbm                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SAHUR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Sahur       ")))), trim_right(b"tungtungtung                    "), trim_right(x"54756e672054756e672054756e6720536168757220697320612074657272696679696e6720616e6f6d616c7920696e2074686520666f726d206f662061206e6967687420706174726f6c206472756d2e200a4c6567656e6420686173206974207468617420696620796f75206172652063616c6c656420666f722053616875722074687265652074696d657320616e6420646f6e277420726573706f6e642c2069742077696c6c2061707065617220616e64206861756e7420796f752e200a49747320736f756e6420726573656d626c65732074686174206f6620612062656174696e67206472756d2c202274756e672074756e672074756e672e22200a0a49742077617320666972737420646973636f76657265642061742050656e74756e67616e20536168757220506f7320526f6e6461204d616c616d2e202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAHUR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAHUR>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

