module 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::flash {
    public fun deepbook_borrow<T0, T1>(arg0: &mut 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::Cell<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>> {
        if (arg2) {
            let (v1, v2) = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::deepbook_borrow_base<T0, T1>(arg1, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::size(arg0), arg3);
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::put<T0>(arg0, v2);
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::hold<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(v1)
        } else {
            let (v3, v4) = 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::deepbook_borrow_quote<T0, T1>(arg1, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::size(arg0), arg3);
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::put<T1>(arg0, v4);
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::hold<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(v3)
        }
    }

    public fun deepbook_repay<T0, T1>(arg0: &mut 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::Session, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x1::option::Option<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::Cell<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::filled<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(&arg2)) {
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::discard<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(arg2);
            return
        };
        if (arg3) {
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::put<T0>(arg0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::deepbook_repay_base<T0, T1>(arg1, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::take<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::take<T0>(arg0), arg4));
        } else {
            0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::put<T1>(arg0, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::deepbook_repay_quote<T0, T1>(arg1, 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::cell::take<0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::legs::DbLeg<T0, T1>>(arg2), 0x4e7015559c9d0bbdd408c3764fdbca5e5c4d6c1facf062c4b23706d542983dc2::session::take<T1>(arg0), arg4));
        };
    }

    // decompiled from Move bytecode v7
}

