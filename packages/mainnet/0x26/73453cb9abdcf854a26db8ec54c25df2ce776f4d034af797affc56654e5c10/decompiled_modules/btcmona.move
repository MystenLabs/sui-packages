module 0x2673453cb9abdcf854a26db8ec54c25df2ce776f4d034af797affc56654e5c10::btcmona {
    struct BTCMONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCMONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCMONA>(arg0, 9, b"BTCMONA ", b"Bitcoin MONA ", b"A deflationary crytocurrency digital asset and a store of values.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdodnkbye1dU67N2fndB8FNkFfB8ZgSgKUpwtGrP3NHMN")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTCMONA>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCMONA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCMONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

