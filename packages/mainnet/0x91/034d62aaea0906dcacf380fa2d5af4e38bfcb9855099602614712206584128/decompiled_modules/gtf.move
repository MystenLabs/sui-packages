module 0x91034d62aaea0906dcacf380fa2d5af4e38bfcb9855099602614712206584128::gtf {
    struct GTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/iZXzpqnXcX6PsYssPwRv8T26RXwgzxPhsj3Syy9aray.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GTF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GTF         ")))), trim_right(b"Flock                           "), trim_right(b"Bringing real world farming to the Blockchain. It's simple , We have sheep and every time they give birth as a reward we airdrop more tokens to holders every 6 months from the airdrop reward pool. Our flock is growing daily and currently we have 350 female sheep waiting to give birth.... Dog's and Turtle's have dominat"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTF>>(v4);
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

