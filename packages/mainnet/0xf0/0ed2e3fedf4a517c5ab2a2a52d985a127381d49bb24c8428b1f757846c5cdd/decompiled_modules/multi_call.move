module 0xf00ed2e3fedf4a517c5ab2a2a52d985a127381d49bb24c8428b1f757846c5cdd::multi_call {
    struct MultiCall<T0, T1> {
        caller: address,
        calls: vector<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>,
        next_index: u64,
    }

    public fun length<T0, T1>(arg0: &MultiCall<T0, T1>) : u64 {
        0x1::vector::length<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>(&arg0.calls)
    }

    public fun borrow_next<T0, T1>(arg0: &mut MultiCall<T0, T1>, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg2: bool) : &mut 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1> {
        let v0 = arg0.next_index;
        assert!(v0 < 0x1::vector::length<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>(&arg0.calls), 1);
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::callee<T0, T1>(0x1::vector::borrow<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>(&arg0.calls, v0)) == 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1), 2);
        if (arg2) {
            arg0.next_index = v0 + 1;
        };
        0x1::vector::borrow_mut<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>(&mut arg0.calls, v0)
    }

    public fun caller<T0, T1>(arg0: &MultiCall<T0, T1>) : address {
        arg0.caller
    }

    public fun create<T0, T1>(arg0: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap, arg1: vector<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>) : MultiCall<T0, T1> {
        MultiCall<T0, T1>{
            caller     : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg0),
            calls      : arg1,
            next_index : 0,
        }
    }

    public fun destroy<T0, T1>(arg0: MultiCall<T0, T1>, arg1: &0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap) : vector<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>> {
        assert!(0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::id(arg1) == arg0.caller, 2);
        let MultiCall {
            caller     : _,
            calls      : v1,
            next_index : _,
        } = arg0;
        v1
    }

    public fun has_next<T0, T1>(arg0: &MultiCall<T0, T1>) : bool {
        arg0.next_index < 0x1::vector::length<0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<T0, T1>>(&arg0.calls)
    }

    public fun next_index<T0, T1>(arg0: &MultiCall<T0, T1>) : u64 {
        arg0.next_index
    }

    // decompiled from Move bytecode v6
}

