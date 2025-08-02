module 0xb38fd4fd628b64b9f0abf202e08129ef1309ab36acb104ee5ac4f027a474eaef::dbk {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::CBM, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            let v0 = 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T1>(arg1, arg4, arg7);
            let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, v0, 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg5, arg7), arg6, arg2, arg7);
            let v4 = v1;
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v4, arg7);
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v2, arg7);
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v3, arg7);
            let v5 = AS{
                ai : 0x2::coin::value<T1>(&v0),
                ao : 0x2::coin::value<T0>(&v4),
            };
            0x2::event::emit<AS>(v5);
        } else {
            let v6 = 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<T0>(arg1, arg4, arg7);
            let (v7, v8, v9) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, v6, 0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::wd<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, arg5, arg7), arg6, arg2, arg7);
            let v10 = v8;
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T0>(arg1, v7, arg7);
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<T1>(arg1, v10, arg7);
            0xe04b8f264c8a29e103e71980987d76a475c8565094b6646e368659a30a9c70ed::bm::dp<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, v9, arg7);
            let v11 = AS{
                ai : 0x2::coin::value<T0>(&v6),
                ao : 0x2::coin::value<T1>(&v10),
            };
            0x2::event::emit<AS>(v11);
        };
    }

    // decompiled from Move bytecode v6
}

