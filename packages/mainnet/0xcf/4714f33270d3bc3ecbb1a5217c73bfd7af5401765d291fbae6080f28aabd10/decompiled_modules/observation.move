module 0xcf4714f33270d3bc3ecbb1a5217c73bfd7af5401765d291fbae6080f28aabd10::observation {
    struct Observation has copy, drop {
        holder: 0x2::object::ID,
        pair_index: u32,
        price: u64,
        publish_time_ms: u64,
        round: u64,
        source: u8,
        quote: u8,
        raw_value: u128,
        raw_decimal: u16,
    }

    public fun holder(arg0: &Observation) : 0x2::object::ID {
        arg0.holder
    }

    fun normalise(arg0: u128, arg1: u16) : u64 {
        assert!(arg1 <= 18, 201);
        let v0 = (arg1 as u128);
        if (v0 == 6) {
            (arg0 as u64)
        } else if (v0 > 6) {
            ((arg0 / (pow10(((v0 - 6) as u64)) as u128)) as u64)
        } else {
            ((arg0 * (pow10(((6 - v0) as u64)) as u128)) as u64)
        }
    }

    public fun numeraire_scale() : u64 {
        1000000
    }

    public fun observe(arg0: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg1: u32, arg2: u8) : Observation {
        let (v0, v1, v2, v3) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg0, arg1);
        assert!(v0 > 0, 200);
        let v4 = normalise(v0, v1);
        assert!(v4 > 0, 200);
        Observation{
            holder          : 0x2::object::id<0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder>(arg0),
            pair_index      : arg1,
            price           : v4,
            publish_time_ms : (v2 as u64),
            round           : (v3 as u64),
            source          : 0,
            quote           : arg2,
            raw_value       : v0,
            raw_decimal     : v1,
        }
    }

    public fun pair_index(arg0: &Observation) : u32 {
        arg0.pair_index
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price(arg0: &Observation) : u64 {
        arg0.price
    }

    public fun publish_time_ms(arg0: &Observation) : u64 {
        arg0.publish_time_ms
    }

    public fun quote(arg0: &Observation) : u8 {
        arg0.quote
    }

    public fun raw_decimal(arg0: &Observation) : u16 {
        arg0.raw_decimal
    }

    public fun raw_value(arg0: &Observation) : u128 {
        arg0.raw_value
    }

    public fun round(arg0: &Observation) : u64 {
        arg0.round
    }

    public fun source(arg0: &Observation) : u8 {
        arg0.source
    }

    public fun source_supra() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

