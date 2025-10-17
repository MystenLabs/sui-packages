module 0x6abd4281465b54d503e38d39e26549fa62c397c92485d44bd7f0d2b95fb4d2a2::lyrics_test {
    struct Lyric has store, key {
        id: 0x2::object::UID,
        lines: vector<LyricLine>,
    }

    struct LyricLine has copy, drop, store {
        timestamp_range: LyricTimestampRange,
        body: 0x1::string::String,
    }

    struct LyricTimestampRange has copy, drop, store {
        pos0: u64,
        pos1: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Lyric {
        Lyric{
            id    : 0x2::object::new(arg0),
            lines : 0x1::vector::empty<LyricLine>(),
        }
    }

    public fun add_line(arg0: &mut Lyric, arg1: LyricLine) {
        0x1::vector::push_back<LyricLine>(&mut arg0.lines, arg1);
    }

    public fun destroy(arg0: Lyric) {
        let Lyric {
            id    : v0,
            lines : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_line(arg0: u64, arg1: u64, arg2: 0x1::string::String) : LyricLine {
        let v0 = LyricTimestampRange{
            pos0 : arg0,
            pos1 : arg1,
        };
        LyricLine{
            timestamp_range : v0,
            body            : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

