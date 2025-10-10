module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_data {
    struct CoinData<phantom T0> has store {
        coin_management: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>,
        coin_info: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>,
    }

    public fun coin_info<T0>(arg0: &CoinData<T0>) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0> {
        &arg0.coin_info
    }

    public(friend) fun coin_info_mut<T0>(arg0: &mut CoinData<T0>) : &mut 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0> {
        &mut arg0.coin_info
    }

    public fun coin_management<T0>(arg0: &CoinData<T0>) : &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0> {
        &arg0.coin_management
    }

    public(friend) fun coin_management_mut<T0>(arg0: &mut CoinData<T0>) : &mut 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0> {
        &mut arg0.coin_management
    }

    public(friend) fun destroy<T0>(arg0: CoinData<T0>) : (0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>, 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>) {
        let CoinData {
            coin_management : v0,
            coin_info       : v1,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun new<T0>(arg0: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>, arg1: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>) : CoinData<T0> {
        CoinData<T0>{
            coin_management : arg0,
            coin_info       : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

